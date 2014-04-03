From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 3 Apr 2014 15:45:11 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for
 v3.15
In-Reply-To: <CAOesGMh9HAxbm8gLaAcFWOX12TjVXpOpUw1aDrOiiO5Uj_Y6Qg@mail.gmail.com>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
 <20140317074611.GH21917@quad.lixom.net>
 <CANqRtoSg8g2vODYaxx7U4BzQxb9piM4Cf_2uBk8O874eopJZsg@mail.gmail.com>
 <CAOesGMh9HAxbm8gLaAcFWOX12TjVXpOpUw1aDrOiiO5Uj_Y6Qg@mail.gmail.com>
Message-ID: <CANqRtoQ-SFsuNsFW34s1_MYnoW0kveAxdByydBq7gNvzm0MTkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Apr 3, 2014 at 3:23 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi Magnus,
>
> On Wed, Apr 2, 2014 at 11:16 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Mon, Mar 17, 2014 at 4:46 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Thu, Mar 06, 2014 at 01:44:28PM +0900, Simon Horman wrote:
>>>> Hi Olof, Hi Kevin, Hi Arnd,
>>>>
>>>> Please consider this fourth round of Renesas ARM based SoC DT updates for v3.15.
>>>>
>>>> This pull request is based on the previous round of
>>>> such requests, tagged as renesas-dt3-for-v3.15,
>>>> which I have already sent a pull-request for.
>>>>
>>>>
>>>> The following changes since commit 367aaaea1d6c6496695ffd06b49590b8cfcb8aa5:
>>>>
>>>>   ARM: shmobile: genmai: adapt dts to use native i2c driver (2014-02-18 11:35:30 +0900)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v3.15
>>>
>>> Hi,
>>>
>>> I've merged this into next/dt. However, a general comment on these patches:
>>>
>>>> Sergei Shtylyov (4):
>>>>       ARM: shmobile: r8a7790: add Ether DT support
>>>>       ARM: shmobile: lager: add Ether DT support
>>>>       ARM: shmobile: r8a7791: add Ether DT support
>>>>       ARM: shmobile: koelsch: add Ether DT support
>>>
>>> I think you should consider doing a generic binding for the ethernet
>>> controller, that specifies the data that the driver needs as part of the device
>>> tree contents. that way you don't have to add a new _data structure for every
>>> new SoC that implements things -- from taking a brief look at the driver there
>>> seems to be a bit of boiler plate and/or several parts that share common
>>> feature sets already.
>>>
>>> Anyway, given the way the binding is written, this can be done later by adding
>>> a generic compatible string that expects more properties, etc -- so it's not
>>> something that needs to be done now. But I do recommend that as you add new
>>> SoCs in the future (if you do).
>>
>> Hi Olof,
>>
>> Thanks for your suggestion. If I understand your proposal correctly
>> then you recommend us to make the driver more generic and
>> configuration driven based on configuration from DT. In general I
>> agree about this direction, but in the case of sh-eth this seems
>> difficult due to huge differences between different IP variants. And
>> to make it worse, the documentation is often of poor quality with no
>> real IP version information. Because of this we keep knowledge in the
>> driver and adjust behavior using the SoC number as suffix in the
>> compatible string. The SoC number is the only "stable id" we have that
>> is suitable for DT ABI unfortunately.
>>
>> Of course I welcome further data sharing, cleanups and bug fixes for
>> this driver. If you can think of anything in particular please let me
>> or one of the sh-eth developers know. I will do my best to help you.
>
>
> My observation was mostly based on the fact that while there are a
> number of tunables in the platform data, there seems to mostly be a
> few different main collections of settings used. I.e. several of them
> seem to share several of the tunables.

I understand and agree. So similar SoCs may share the same tunables,
but if this is correct or not for all cases remains to be seen.

Actually, for sh-eth the documentation has been so poor that for some
SoCs we have to rely on undocumented registers. Because of the lacking
docs the question in my mind is where to draw the line for the ABI. By
keeping the compatible string fixed to the SoC suffix we make sure the
DTB remains compatible as long as the driver knows how to handle the
hardware. Then when we get a surprise data sheet update then we don't
have to break the ABI.

> Maybe that's mostly coincidental, or maybe it's an indication that
> most "similar-timeframe" SoCs used similar settings -- I don't know
> enough to tell. Which is why I brought it up.

Historically this driver was initially developed for SH-based SoCs,
and because of that the platform data interface supports a wider range
of devices than DT which is ARM-only. There may be some
"similar-timeframe" cases too. But for sh-eth it is a mix of fast and
gigabit ethernet controllers with RMII or GMII interfaces.

One way to deal with "similar tunables" is to break out similar
versions of the IP into a certain "software defined IP block version",
but wouldn't we describe the current state of the driver then instead
of the actual hardware? Just because the driver may work with two
different IP versions does not mean they are naturally hardware
compatible in my opinion.

To keep things simple I'd like to enforce a "SoC suffix" compatible
string policy for our drivers. I know it does not scale but in my
opinion this is the place for simplicity and stability. In parallel we
need to work on getting the IP version described in the documentation
as expected. Once we have IP version in the documentation then we can
use that in the compatible string and then hopefully we are in a
better place.

Thanks,

/ magnus
