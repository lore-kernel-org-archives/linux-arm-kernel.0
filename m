From: alchark@gmail.com (Alexey Charkov)
Date: Mon, 1 Nov 2010 21:31:14 +0300
Subject: [PATCH 3/6] input: Add support for VIA VT8500 and compatibles in
	i8042
In-Reply-To: <4CCC9AEB.7060101@fluff.org>
References: <1287608139-21354-1-git-send-email-alchark@gmail.com>
	<1287608139-21354-3-git-send-email-alchark@gmail.com>
	<4CCC9AEB.7060101@fluff.org>
Message-ID: <AANLkTini9jZHtH+Bp4dgdQ6A-=7iAe71YJ_KnMjJqbTN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/31 Ben Dooks <ben-linux@fluff.org>:
> On 20/10/10 21:55, Alexey Charkov wrote:
>> VIA and WonderMedia Systems-on-Chip feature a standard i8042-compatible
>> keyboard and mouse controller. This adds necessary glue to enable use
>> of the standard driver with these systems.
>>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>
>> Please review and state whether this could be acceptable for a merge
>> to mainline in the coming 2.6.37 window. If possible, I would deeply
>> appreciate a merge to a relevant git tree for integration prior to
>> asking Linus to pull the changes. I could rebase the code if needed,
>> currently this is against Linus' master branch.
>>
>> This patch relies on the basic architecture support for VT8500/WM8505
>> to be in place, as introduced by PATCH 1/6 in this series.
>>
>> Due credits go to the community for providing feedback, advice and
>> testing.
>>
>> NB: The development is being done at:
>> http://gitorious.org/linux-on-via-vt8500/vt8500-kernel
>>
>> Relevant code may be pulled from a git tree in there.
>>
>> ?drivers/input/serio/Kconfig ? ? ? ?| ? ?3 +-
>> ?drivers/input/serio/i8042-vt8500.h | ? 71 ++++++++++++++++++++++++++++++++++++
>> ?drivers/input/serio/i8042.h ? ? ? ?| ? ?2 +
>> ?3 files changed, 75 insertions(+), 1 deletions(-)
>> ?create mode 100644 drivers/input/serio/i8042-vt8500.h
>>
>> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
>> index 3bfe8fa..2b86774 100644
>> --- a/drivers/input/serio/Kconfig
>> +++ b/drivers/input/serio/Kconfig
>> @@ -21,7 +21,8 @@ if SERIO
>> ?config SERIO_I8042
>> ? ? ? tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
>> ? ? ? default y
>> - ? ? depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
>> + ? ? depends on !PARISC && \
>> + ? ? ? ? ? ? ? (!ARM || ARCH_SHARK || ARCH_VT8500 || FOOTBRIDGE_HOST) && \
>> ? ? ? ? ? ? ? ? ?(!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN
>
> this looks like someone could do with a HAS_SERIO_I8042 Kconfig entry
> and have the relevant archs select it instead of having this mess.
>
>

True, it would make things much cleaner. However, that's probably out
of scope of adding VT8500 support here, thus not for me to decide :)

<snip>

>
> yeurk... how about having a core i8042 implementation and having
> a structure with the necessary callbacks for the code, so that
> we don't end up having to select what is builtin for the system
> we're compiling for?
>

I would really like to see this implemented as a standard platform
driver (accepting resources and platform_data as necessary). This
would be a way cleaner approach, with less code duplication and less
patching of the driver itself whenever a new platform is to be added.
However, I don't know how that kind of a change would affect other
arches.

> --
> Ben
>

Thanks,
Alexey
