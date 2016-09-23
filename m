From: edumazet@google.com (Eric Dumazet)
Date: Fri, 23 Sep 2016 09:54:38 -0700
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
References: <troy.kisky@boundarydevices.com>
 <02afb707-65de-5101-a79b-355929c4e00b@nelint.com>
Message-ID: <CANn89iLb+QJu+MYh859oAAjcLCsKRpBbzVf43yOdq+HJVtZDpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 9:43 AM, Eric Nelson <eric@nelint.com> wrote:
>
> Hello all,
>
> We're seeing alignment issues from the ethernet stack on an i.MX6UL board:
>
> root at mx6ul:~# cat /proc/cpu/alignment
> User: 0
> System: 470010 (inet_gro_receive+0x104/0x278)
>
> This seems to be related to the ip header alignment, and there
> was much discussion in mailing list threads [1] and [2].
>
> In particular, Russell referred to a patch here, but I haven't been
> able to find it:
> https://lists.linaro.org/pipermail/linaro-toolchain/2012-October/002844.html
>
> Eric Dumazet also suggested a path toward fixing it, but I don't quite
> understand the suggestion:
> http://www.spinics.net/lists/netdev/msg213166.htm
>
> The immediate problem is addressed by just reading the id and frag_offs
> fields in the iphdr structure as shown in this patch:
>
> commit 98810abc911b1286a7e4a2ebdfbad66f12fae19d
> Author: Eric Nelson <eric@nelint.com>
> Date: Fri Sep 23 08:26:03 2016 -0700
>
> net: ipv4: af_inet: don't read multiple 16-bit iphdr fields as a 32-bit
> value
>
> Change-Id: Idc7122c22c13ca078be31907d30ab1c3148ba807
> Signed-off-by: Eric Nelson <eric@nelint.com>
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 0cc98b1..c17ef6e 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1301,6 +1301,7 @@ static struct sk_buff **inet_gro_receive(struct
> sk_buff **head,
> unsigned int hlen;
> unsigned int off;
> unsigned int id;
> + unsigned int frag;
> int flush = 1;
> int proto;
>
> @@ -1326,9 +1327,9 @@ static struct sk_buff **inet_gro_receive(struct
> sk_buff **head,
> if (unlikely(ip_fast_csum((u8 *)iph, 5)))
> goto out_unlock;
>
> - id = ntohl(*(__be32 *)&iph->id);
> - flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id & ~IP_DF));
> - id >>= 16;
> + id = ntohs(*(__be16 *)&iph->id);
> + frag = ntohs(*(__be16 *)&iph->frag_off);
> + flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (frag &
> ~IP_DF));
>
> for (p = *head; p; p = p->next) {
> struct iphdr *iph2;
>

This solves nothing, because a few lines after you'll have yet another
unaligned access :


((__force u32)iph->saddr ^ (__force u32)iph2->saddr) |
((__force u32)iph->daddr ^ (__force u32)iph2->daddr)) {

So you might have one less problematic access, out of hundreds of them
all over the places.

Really the problem is that whole stack depends on the assumption that
IP headers are aligned on arches that care
(ie where NET_IP_ALIGN == 2)

If your build does have NET_IP_ALIGN = 2 and you get a fault here, it
might be because of a buggy driver.

The other known case is some GRE encapsulations that break the
assumption, and this is discussed somewhere else.
