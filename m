From: lacombar@gmail.com (Arnaud Lacombe)
Date: Mon, 1 Aug 2011 12:08:08 -0400
Subject: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
In-Reply-To: <CAGZ=bqL=VAx5jnSBkE2q5KJSY_+An-VRTRAzJmJ3waQUvrRFFg@mail.gmail.com>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
	<20110801083614.GC15578@n2100.arm.linux.org.uk>
	<CAMuHMdUpTDSRP_JmWqcCBtYwzna0hwmaBshpiF8kgvqoNcqYZA@mail.gmail.com>
	<20110801101410.GE15578@n2100.arm.linux.org.uk>
	<CAMuHMdUiLjMVwOqKPF6tHLpPxROrx=rRf3ednfTLrwGuZ2VF7A@mail.gmail.com>
	<CACqU3MVUxTYmD+4VGBAeN8PTs83fR0xQQrQS5h4QGMZXgMxEvA@mail.gmail.com>
	<CAGZ=bqL=VAx5jnSBkE2q5KJSY_+An-VRTRAzJmJ3waQUvrRFFg@mail.gmail.com>
Message-ID: <CACqU3MUoxSNmcYsSF4zOTgADdedb7TcciPuBPMviG02M5oUPDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 1, 2011 at 11:15 AM, Kyle Moffett <kyle@moffetthome.net> wrote:
> On Mon, Aug 1, 2011 at 11:04, Arnaud Lacombe <lacombar@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Aug 1, 2011 at 7:27 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Mon, Aug 1, 2011 at 12:14, Russell King - ARM Linux
>>>>>[...]
>>>>>
>>>>> Doesn't kconf error out when trying to select a non-existent symbol?
>>>>
>>>> Nope.
>>>
>>> You're right. So that's a bug.
>>>
>> depends on what you are trying to achieve and what the problem is.
>>
>> Internally kconfig will create a dummy symbol when it encounter a
>> missing symbol so that arch/arm/Kconfig can reference a symbol which
>> will be fully defined later on. I do not think you want to forward
>> decl all the symbol which can be used. That'd be a mess. That said, we
>> can come with a form of symbol deprecation that would error-out when
>> used.
>
> Would it be possible instead to make Kconfig go through all the symbols
> after everything is processed and identify any remaining "dummy symbols"
> which were not actually declared anywhere?
>
this is software, everything is possible.

> Right now if you typo a "select" statement you get no warnings that you
> are selecting something that does not exist, which is probably a cause
> of many kinds of errors beyond this particular one.
>
d'oh! ... I'm not sure we want that. Dummy symbol are heavily used
internally, a trivial implementation[0] triggered:

% make REGENERATE_PARSERS=y alldefconfig 2>&1 | grep 'defined without
type' | wc -l
817

Moreover, this approach is deemed to fail. The current symbol
namespace is tied to an arch, so whenever you do:

arch/arm/Kconfig:
config FOO
    bool

config BAZ
    bool

drivers/cpufreq/Kconfig
config BAR
    depends on ARM && FOO
    select BAZ

You will end up triggering the warning for every ARCH != ARM...

 - Arnaud

[0]: or rather a fix as we currently only do the check for symbol linked to menu
