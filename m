From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 03 Apr 2013 17:06:17 +0100
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3dKD4G0E8qoxTR2HnJVdagoeOerM+TiZzkJUPjcGwYdX_Q@mail.gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
 <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
 <1364920809.3019.30.camel@hornet>
 <CAHTX3dKD4G0E8qoxTR2HnJVdagoeOerM+TiZzkJUPjcGwYdX_Q@mail.gmail.com>
Message-ID: <1365005177.26858.11.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-03 at 07:33 +0100, Michal Simek wrote:
> The point is different. Was there any reason why you used this static
> mapping
> and then dynamic?
> This code:
>         iotable_init(&vexpress_dt_cortex_a9_scu_map, 1);
>         vexpress_dt_cortex_a9_scu_base = ioremap(phys_addr, SZ_256);

The SCU code is being used very early - too early for "normal" ioremap()
(one problem I'm aware of is lack of kmalloc, but there may be more). So
the static mapping is required. Now, traditionally there was some (more
or less cryptic) pointer arithmetic was used (eg. "base = map_virt_addr
+ 0x100"). I'm sure some would argue it's fine, but I personally dislike
it. Then Nico Pitre's patches made the ioremap() aware of the static
mappings so it will reuse them when possible. Of course it would be
better to be able to do normal ioremap() without any tricks, but it's
another story and I don't feel like discussing it.

So, to summarize, the static mapping is there to make the ioremap()
possible in the first place. If your ioremap() works without it (which
means that you're doing it late enough) you can ignore the
iotable_init() completely.

Does this answer the question?

Pawe?
