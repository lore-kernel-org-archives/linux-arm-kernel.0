From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 11 Feb 2013 19:15:19 +0000
Subject: [PATCH 09/17] ARM: add atag32_to_cpu() function
In-Reply-To: <20130209120331.GC17833@n2100.arm.linux.org.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-10-git-send-email-ben.dooks@codethink.co.uk>
 <20130209120331.GC17833@n2100.arm.linux.org.uk>
Message-ID: <51194347.9090501@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/13 12:03, Russell King - ARM Linux wrote:
> On Fri, Feb 08, 2013 at 11:17:39PM +0000, Ben Dooks wrote:
>> Add atag32_to_cpu() function to allow code manipulating ATAGs to deal
>> with the case where the boot-loader was in little-endian and Linux is
>> running big-endian.
> ...
>> +#ifdef CONFIG_CPU_BE8_BOOT_LE
>> +#define atag32_to_cpu(x)	le32_to_cpu(x)
>> +#else
>> +#define atag32_to_cpu(x)	x
>> +#endif
>
> Actually, with a LE kernel, le32_to_cpu() ends up being a no-op too.  So
> I'm wondering if we should do this a different way...
>
> Also, this will cause sparse to complain - le32_to_cpu() takes a le32
> type not a u32 type.

Yes, you're right on that.

> This brings up a whole load of difficulties though: what format are the
> ATAGs on older BE hardware - I bet it's CPU-endian format there.  So,
> I'm wondering if we should do this:

It isn't defined, and I have failed to find any information on
it online. I have no idea if the IXP devices ran their boot-loader
in big-endian or little-endian format?

Input welcome from anyone who can remember.

> 1. define all tags using a new __atagXX, etc types.
> 2. always use atagXX_to_cpu() to read these.
> 3. Implement:
>
> #if defined(CONFIG_ATAG_LE)
> typedef __le32 __atag32;
> ...
> #define atag32_to_cpu(x) le32_to_cpu(x)
> ...
> #elif defined(CONFIG_ATAG_BE)
> typedef __be32 __atag32;
> ...
> #define atag32_to_cpu(x) be32_to_cpu(x)
> ...
> #elif defined(CONFIG_ATAG_NE)
> typedef __u32 __atag32;
> ...
> #define atag32_to_cpu(x) x
> ...
> #endif
>
> and select the appropriate definition.  Obviously, this is a fundamental
> configuration just like the overall BE/LE configuration of the kernel.

Ok, should I sort out doing that for the next round of patches?

Should the ATAG_xx configurations go into arch/arm/Kconfig or
is there somewhere better for them to go?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
