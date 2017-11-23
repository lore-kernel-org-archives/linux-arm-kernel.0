From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Thu, 23 Nov 2017 09:49:36 +0530
Subject: [PATCH net] net: thunderx: Fix TCP/UDP checksum offload for IPv6
 pkts
In-Reply-To: <1511366238.16595.1.camel@gmail.com>
References: <20171122123727.23580-1-aleksey.makarov@auriga.com>
 <1511366238.16595.1.camel@gmail.com>
Message-ID: <CA+sq2Ce+Qx=ouzieFLBQBhyhMMduzvQKu-iV837njnEMuCdWyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 9:27 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Wed, 2017-11-22 at 15:37 +0300, Aleksey Makarov wrote:
>> From: Sunil Goutham <sgoutham@cavium.com>
>>
>> This fixes a previous patch which missed some changes
>> and due to which L3 checksum offload was getting enabled
>> for IPv6 pkts. And HW is dropping these pkts as it assumes
>> the pkt is IPv4 when IP csum offload is set in the SQ
>> descriptor.
>>
>> Fixes: bbbb494fd005 ("net: thunderx: Enable TSO and checksum offloads
>> for ipv6")
>> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> ---
>>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
>> b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
>> index d4496e9afcdf..184d5bdbe7e0 100644
>> --- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
>> +++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
>> @@ -1355,10 +1355,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic,
>> struct snd_queue *sq, int qentry,
>>
>>       /* Offload checksum calculation to HW */
>>       if (skb->ip_summed == CHECKSUM_PARTIAL) {
>> -             hdr->csum_l3 = 1; /* Enable IP csum calculation */
>>               hdr->l3_offset = skb_network_offset(skb);
>>               hdr->l4_offset = skb_transport_offset(skb);
>>
>> +             /* Enable IP HDR csum calculation for V4 pkts */
>> +             hdr->csum_l3 = (ip.v4->version == 4) ? 1 : 0;
>
> Have you tried to set hdr->csum_l3 to 0 regardless of version being 4
> or 6 ?
>
> This would remove the need for yet another conditional.
>
> AFAIK, linux does not offload IPv4 header checksums to NIC, it is not
> worth the trouble.

Looks like I misunderstood the IPSUM netdev feature flag.
Thanks, will check.

Sunil.

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
