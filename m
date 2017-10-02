From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Oct 2017 16:03:50 +0100
Subject: v4.14-rc2/arm64 kernel BUG at net/core/skbuff.c:2626
In-Reply-To: <1506955708.8061.5.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20171002104947.GE20737@leverpostej>
 <CANn89i++X2rzsaHkTRayMpCED_exL8WPq12=RwD_hXsZ6cN-wQ@mail.gmail.com>
 <20171002142156.GB21696@leverpostej>
 <1506955708.8061.5.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <20171002150350.GD21696@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 07:48:28AM -0700, Eric Dumazet wrote:
> Please try the following fool proof patch.
> 
> This is what I had in my local tree back in August but could not
> conclude on the syzkaller bug I was working on.

Thanks, I'll give this a go shortly.

I'm currently minimizing the Syzkaller log so that I can trigger the
issue more quickly (and have some confidence in a Tested-by)!

Thanks,
Mark.

> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 681e33998e03b609fdca83a83e0fc62a3fee8c39..e51d777797a927058760a1ab7af00579f7488cb5 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -732,7 +732,8 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>  		room = 576;
>  	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
>  	room -= sizeof(struct icmphdr);
> -
> +	if (room < 0)
> +		goto ende;
>  	icmp_param.data_len = skb_in->len - icmp_param.offset;
>  	if (icmp_param.data_len > room)
>  		icmp_param.data_len = room;
> 
> 
> 
