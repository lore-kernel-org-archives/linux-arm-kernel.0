From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 14:32:28 +0530
Subject: [PATCH V4 06/62] ST SPEAr13XX: Adding machine specific header
	files
In-Reply-To: <4D366ABD.4010809@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<91343ab3cb64f7082111535a9a3c006e958578fb.1295333958.git.viresh.kumar@st.com>
	<20110118160037.GC16980@n2100.arm.linux.org.uk>
	<4D366ABD.4010809@st.com>
Message-ID: <4D36A8A4.5010706@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2011 10:08 AM, viresh kumar wrote:
> On 01/18/2011 09:30 PM, Russell King - ARM Linux wrote:
>> On Tue, Jan 18, 2011 at 12:41:34PM +0530, Viresh Kumar wrote:
>>> +#define MISC_BASE		VA_SPEAR13XX_MISC_BASE
>>> +
>>> +/* General Configuration */
>>> +#define SOC_CFG			((unsigned int *)(MISC_BASE + 0x000))
>>> +#define BOOTSTRAP_CFG		((unsigned int *)(MISC_BASE + 0x004))
>>
>> You could really do with an IOMEM() macro, thus:
>>
>> #ifndef __ASSEMBLY__
>> #define IOMEM(x)	((void __iomem __force *)(x))
>> #else
>> #define IOMEM(x)	(x)
>> #endif
>>
>> You can then use that for stuff like VA_SPEAR13XX_MISC_BASE, and all
>> these definitions then become:
>>
>> #define SOC_CFG			(MISC_BASE + 0x000)
>>
>> because GCC allows void pointer arithmetic (treats it as char).
>>
> 
> Yes. I agree with this solution.
> Actually the VA* macros are like:
> #define VA_SPEAR13XX_MISC_BASE		IO_ADDRESS(SPEAR13XX_MISC_BASE)
> 
> Adding IOMEM() over IO_ADDRESS(SPEAR13XX_MISC_BASE) will make it too long.
> And might cross 80 columns. Can we modify IO_ADDRESS() to use IOMEM()?
> 

Russell,

I tried to change IO_ADDRESS() to use IOMEM. But even this doesn't seem to be a
good enough solution. __typesafe_io expects unsigned long and we have:
define __io_address(n)		__io(IO_ADDRESS(n)).

Also, struct map_desc, .virtual field expects unsigned long, where we are getting
warnings.

I tried looking at what others did, and found either they are using (unsigned int *)
(as  earlier done by us) or casting with (unsigned long) for new warnings mentioned
above.

Both didn't seem to be good enough to me. Maybe we can use IOMEM only for MISC_BASE
and similar places, where we had been using (unsigned int *).

I will do this in V5, unless you suggest something better.

-- 
viresh
