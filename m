From: stuart.menefy@st.com (Stuart Menefy)
Date: Tue, 10 Aug 2010 15:07:09 +0100
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by	"ARM:
	Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <20100808220035.GD23623@n2100.arm.linux.org.uk>
References: <4C5ED116.5000002@arndnet.de>
	<20100808220035.GD23623@n2100.arm.linux.org.uk>
Message-ID: <4C615D0D.2080600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/10 23:00, Russell King - ARM Linux wrote:
> On Sun, Aug 08, 2010 at 05:45:26PM +0200, Arnd Hannemann wrote:
>> Hi Russell,
>>
>> your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
>> ARM: Prohibit ioremap() on kernel managed RAM
>>
>> lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
>> fail for the sh_mobile_ceu_camera driver (see backtrace below).
>> I think, other configurations (i.MX31 users of the mx3_camera driver:
>> pcm037 and mx31moboard) will have the same problem.
>>
>> Since I have no idea how to fix this, I post this regression report here...
> 
> Me neither!  However, reverting the commit isn't the answer.
> 
> ARM shmobile platforms are ARM architecture V6 or V7, both of which have
> the architectural restriction that multiple mappings of the same physical
> address space must have the same memory type and cache attributes.  We
> know that some ARMv7 systems do bad things when multiple different
> mappings exist - and as they're using ARM's own Cortex CPU designs, and
> I doubt shmobile is any different in that...
> 
> So, basically going forward with the advent of VIPT caches on ARM, any
> kernel interface which allows system RAM to be remapped with different
> attributes from the lowmem mapping is bad news - that means (eg) using
> vmap() with a non-PGPROT_KERNEL pgprot has become illegal.  Certainly
> using ioremap() on mapped system RAM on VIPT has become illegal, and
> that's what has now been prevented.
> 
> It's actually a restriction which x86 gained some time ago, which I
> stupidly continued to permit on ARM.  Now that our hardware has gained
> the same restriction, we're now going to be into the same learning
> curve...

Doesn't dma_alloc_coherent() suffer from the same problems? Pages are
allocated using alloc_pages, and in the non-coherent case will be
mapped uncached into consistent mapping region, creating a second
mapping with different attributes.

Stuart
