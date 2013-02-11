From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Feb 2013 19:30:59 +0000
Subject: [PATCH 09/17] ARM: add atag32_to_cpu() function
In-Reply-To: <51194347.9090501@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-10-git-send-email-ben.dooks@codethink.co.uk>
 <20130209120331.GC17833@n2100.arm.linux.org.uk>
 <51194347.9090501@codethink.co.uk>
Message-ID: <20130211193059.GN17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 07:15:19PM +0000, Ben Dooks wrote:
> It isn't defined, and I have failed to find any information on
> it online. I have no idea if the IXP devices ran their boot-loader
> in big-endian or little-endian format?

It will be native endian, because that's the format which we've supported
up to now.

>> 1. define all tags using a new __atagXX, etc types.
>> 2. always use atagXX_to_cpu() to read these.
>> 3. Implement:
>>
>> #if defined(CONFIG_ATAG_LE)
>> typedef __le32 __atag32;
>> ...
>> #define atag32_to_cpu(x) le32_to_cpu(x)
>> ...
>> #elif defined(CONFIG_ATAG_BE)
>> typedef __be32 __atag32;
>> ...
>> #define atag32_to_cpu(x) be32_to_cpu(x)
>> ...
>> #elif defined(CONFIG_ATAG_NE)
>> typedef __u32 __atag32;
>> ...
>> #define atag32_to_cpu(x) x
>> ...
>> #endif
>>
>> and select the appropriate definition.  Obviously, this is a fundamental
>> configuration just like the overall BE/LE configuration of the kernel.
>
> Ok, should I sort out doing that for the next round of patches?

Yes please.

> Should the ATAG_xx configurations go into arch/arm/Kconfig or
> is there somewhere better for them to go?

arch/arm/Kconfig for the time being.  I've debated about moving some
config options to arch/arm/boot/Kconfig
