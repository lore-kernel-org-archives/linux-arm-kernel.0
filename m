From: phil@nwl.cc (Phil Sutter)
Date: Fri, 6 May 2011 18:12:09 +0200
Subject: ARM, AF_PACKET: caching problems on Marvell Kirkwood
In-Reply-To: <1304607362.3032.84.camel@edumazet-laptop>
References: <20110408130643.GA8730@orbit.nwl.cc>
	<20110505141107.GC30443@orbit.nwl.cc>
	<1304607362.3032.84.camel@edumazet-laptop>
Message-ID: <20110506161209.GB20777@orbit.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 05, 2011 at 04:56:02PM +0200, Eric Dumazet wrote:
> I assume you use latest linux-2.6 or net-next-2.6 ?

Well, initially we noticed the problem on 2.6.34.7, but I verified it
against both 2.6.37 and linux-2.6 from three days ago.

> Could you try to force vmalloc() use ?
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index b5362e9..0b5a89c 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2383,7 +2383,7 @@ static inline char *alloc_one_pg_vec_page(unsigned long order)
>  	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>  			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>  
> -	buffer = (char *) __get_free_pages(gfp_flags, order);
> +	buffer = NULL;
>  
>  	if (buffer)
>  		return buffer;

Thanks for the hint. I tried that, but the problem persists.

Greetings, Phil
