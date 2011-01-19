From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 10:08:21 +0530
Subject: [PATCH V4 06/62] ST SPEAr13XX: Adding machine specific header
	files
In-Reply-To: <20110118160037.GC16980@n2100.arm.linux.org.uk>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<91343ab3cb64f7082111535a9a3c006e958578fb.1295333958.git.viresh.kumar@st.com>
	<20110118160037.GC16980@n2100.arm.linux.org.uk>
Message-ID: <4D366ABD.4010809@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2011 09:30 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 12:41:34PM +0530, Viresh Kumar wrote:
>> +#define MISC_BASE		VA_SPEAR13XX_MISC_BASE
>> +
>> +/* General Configuration */
>> +#define SOC_CFG			((unsigned int *)(MISC_BASE + 0x000))
>> +#define BOOTSTRAP_CFG		((unsigned int *)(MISC_BASE + 0x004))
> 
> You could really do with an IOMEM() macro, thus:
> 
> #ifndef __ASSEMBLY__
> #define IOMEM(x)	((void __iomem __force *)(x))
> #else
> #define IOMEM(x)	(x)
> #endif
> 
> You can then use that for stuff like VA_SPEAR13XX_MISC_BASE, and all
> these definitions then become:
> 
> #define SOC_CFG			(MISC_BASE + 0x000)
> 
> because GCC allows void pointer arithmetic (treats it as char).
> 

Yes. I agree with this solution.
Actually the VA* macros are like:
#define VA_SPEAR13XX_MISC_BASE		IO_ADDRESS(SPEAR13XX_MISC_BASE)

Adding IOMEM() over IO_ADDRESS(SPEAR13XX_MISC_BASE) will make it too long.
And might cross 80 columns. Can we modify IO_ADDRESS() to use IOMEM()?

-- 
viresh
