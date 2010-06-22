From: mike@compulab.co.il (Mike Rapoport)
Date: Tue, 22 Jun 2010 10:38:01 +0300
Subject: [PATCH 1/4] [ARM] Remove now unnecessary dma_needs_bounce()
In-Reply-To: <AANLkTimugHXfVUcEmq_DwaSLwelvnS9QoDJcxJaphahJ@mail.gmail.com>
References: <1275724538-5075-1-git-send-email-eric.y.miao@gmail.com>
	<1275724538-5075-2-git-send-email-eric.y.miao@gmail.com>
	<AANLkTilJ3UpyHEplDqS_nV8SVDcl_pRRn4glDn7JS1GW@mail.gmail.com>
	<4C1EFABC.4020601@compulab.co.il>
	<AANLkTimugHXfVUcEmq_DwaSLwelvnS9QoDJcxJaphahJ@mail.gmail.com>
Message-ID: <4C206859.6090604@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

Eric Miao wrote:
> 2010/6/21 Mike Rapoport <mike@compulab.co.il>:
>> Eric
>>
>> Eric Miao wrote:
>>> On Sat, Jun 5, 2010 at 3:55 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>>> With a correct dev->dma_mask before calling dmabounce_register_dev(),
>>>> dma_needs_bounce() is not necessary.
>>>>
>>>> The above is true for it8152.c and ixp4xx/common-pci.c.
>>>>
>>>> The sa1111, though, is a bit complicated. Until it's fully understood
>>>> and fixed, dma_needs_bounce() for sa1111 is kept if CONFIG_SA1111 is
>>>> enabled with no side effect (with the condition of machine_is_*)
>>>>
>>> Sorry I forgot to CC you two. Any feedback is welcome, thanks.
>> Can I pull these changes from your git tree?
> 
> Sorry, just pushed them to the branch below:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
> defconfig_cleanup

Can you please enroll the below patch into your tree? Otherwise the kernel
build fails if CONFIG_SA1111 is not selected and I hardly believe anyone
would use pxa2xx_defconfig on CM-X270 :)

Except that, IT8152 works fine and IT8152 part can have
Acked-by: Mike Rapoport <mike@compulab.co.il>


diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c80d4d2..8bc64bd 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -301,7 +301,8 @@ extern void dmabounce_unregister_dev(struct device *);
  #ifdef CONFIG_SA1111
  extern int dma_needs_bounce(struct device*, dma_addr_t, size_t);
  #else
-static inline int dma_needs_bounce(struct device*, dma_addr_t, size_t)
+static inline int dma_needs_bounce(struct device* dev, dma_addr_t dma_addr,
+				   size_t size)
  {
  	return 0;
  }


-- 
Sincerely yours,
Mike.
