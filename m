From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Thu, 2 Nov 2017 12:21:57 +0100
Subject: [PATCH v3 1/1] xdp: Sample xdp program implementing ip forward
In-Reply-To: <1509522484-30215-2-git-send-email-christina.jacob.koikara@gmail.com>
References: <1509522484-30215-1-git-send-email-christina.jacob.koikara@gmail.com>
 <1509522484-30215-2-git-send-email-christina.jacob.koikara@gmail.com>
Message-ID: <20171102122157.2dcb2da7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Nov 2017 13:18:04 +0530 Christina Jacob <christina.jacob.koikara@gmail.com> wrote:

> From: Christina Jacob <Christina.Jacob@cavium.com>
> 
> Implements port to port forwarding with route table and arp table
> lookup for ipv4 packets using bpf_redirect helper function and
> lpm_trie  map.
> Signed-off-by: Christina Jacob <Christina.Jacob@cavium.com>

There is usually a line between the desc and Signed-off-by.

> ---
>  samples/bpf/Makefile               |   4 +
>  samples/bpf/xdp_router_ipv4_kern.c | 181 ++++++++++
>  samples/bpf/xdp_router_ipv4_user.c | 657 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 842 insertions(+)
> 
[...]
> diff --git a/samples/bpf/xdp_router_ipv4_kern.c b/samples/bpf/xdp_router_ipv4_kern.c
> new file mode 100644
> index 0000000..70a5907
> --- /dev/null
> +++ b/samples/bpf/xdp_router_ipv4_kern.c
> @@ -0,0 +1,181 @@
> +/* Copyright (C) 2017 Cavium, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License
> + * as published by the Free Software Foundation.
> + */
[...]
> +SEC("xdp3")
> +int xdp_prog3(struct xdp_md *ctx)

You changed the filename from xdp3 to xdp_router_ipv4, but you didn't
change the name in he code.

> +{
> +	void *data_end = (void *)(long)ctx->data_end;
> +	__be64 *dest_mac = NULL, *src_mac = NULL;
> +	void *data = (void *)(long)ctx->data;
> +	struct trie_value *prefix_value;
> +	int rc = XDP_DROP, forward_to;
> +	struct ethhdr *eth = data;
> +	union key_4 key4;
> +	long *value;
> +	u16 h_proto;
> +	u32 ipproto;
> +	u64 nh_off;
> +
[..]
> +	if (h_proto == htons(ETH_P_ARP)) {
> +		return XDP_PASS;
> +	} else if (h_proto == htons(ETH_P_IP)) {
> +		struct direct_map *direct_entry;
> +		__be32 src_ip = 0, dest_ip = 0;
> +
> +		ipproto = parse_ipv4(data, nh_off, data_end, &src_ip, &dest_ip);
> +		direct_entry = (struct direct_map *)bpf_map_lookup_elem
> +			(&exact_match, &dest_ip);

I don't think you need this type-casting.


> +		/* Check for exact match, this would give a faster lookup*/
> +		if (direct_entry && direct_entry->mac && direct_entry->arp.mac) {
> +			src_mac = &direct_entry->mac;
> +			dest_mac = &direct_entry->arp.mac;
> +			forward_to = direct_entry->ifindex;
> +		} else {
> +			/* Look up in the trie for lpm*/
> +			key4.b32[0] = 32;
> +			key4.b8[4] = dest_ip & 0xff;
> +			key4.b8[5] = (dest_ip >> 8) & 0xff;
> +			key4.b8[6] = (dest_ip >> 16) & 0xff;
> +			key4.b8[7] = (dest_ip >> 24) & 0xff;
> +			prefix_value = ((struct trie_value *)bpf_map_lookup_elem
> +					(&lpm_map, &key4));
> +			if (!prefix_value)
> +				return XDP_DROP;
> +			src_mac = &prefix_value->value;
> +			if (!src_mac)
> +				return XDP_DROP;
> +			dest_mac = (__be64 *)bpf_map_lookup_elem(&arp_table, &dest_ip);
> +			if (!dest_mac) {
> +				if (!prefix_value->gw)
> +					return XDP_DROP;
> +				dest_ip = *(__be32 *)&prefix_value->gw;
> +				dest_mac = (__be64 *)bpf_map_lookup_elem(&arp_table, &dest_ip);
> +			}
> +			forward_to = prefix_value->ifindex;
> +		}
> +	} else {
> +		ipproto = 0;
> +	}
> +	if (src_mac && dest_mac) {
> +		set_src_dst_mac(data, src_mac, dest_mac);
> +		value = bpf_map_lookup_elem(&rxcnt, &ipproto);
> +		if (value)
> +			*value += 1;
> +		return  bpf_redirect(forward_to, 0);

Notice that using bpf_redirect() is slow, while using bpf_redirect_map()
is fast.  Using bpf_redirect_map() requires a little more book keeping,
but the performance gain is worth it.

Raw benchmarks on my system show:
 * bpf_redirect() max at  7Mpps
 * bpf_redirect_map() at 13Mpps

Trying out your program on my systems showed it jumps between 5.6Mpps
to 7Mpps.  And it seems to be correlated with matching direct_entry.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
