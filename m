From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jul 2018 07:34:05 -0700
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
In-Reply-To: <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
References: <20180715035342.11371-1-olof@lixom.net>
 <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
Message-ID: <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 2:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Olof,
>
> On 15/07/18 04:53, Olof Johansson wrote:
>> There's some use in printing out what the implementer and part numbers
>> decode to for cases where they're known.
>>
>> I filled in the table based on public information; mostly from ARM TRMs
>> and other tools (and some of the SSBD tables in the kernel, etc).
>>
>> Apple IDs came from
>> https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>  arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 76 insertions(+), 3 deletions(-)
>
> [...]
>
> The same thing pops up every so often. And the answer is the same each time:

Ever thought about why it pops up?

> - it breaks an existing userspace ABI by changing the format of cpuinfo

Most tools likely rely on a per-line format, and in this case they're
likely interpreting the contents after the ':' as an integer. Adding
something to the line might or might not break them, agreed.

How about introducing a "CPU model" line similar to x86's cleartext one?

> - it is unmaintainable in the long run

False. Chances are you already need details more fine-grained than
this for errata and quirks, we already do for SSBD. And if it lacks an
entry it's not the end of the world.

> - userspace already has this information by simply running "lscpu"
>
> What has changed?

What has changed is that ARM(64) is moving from a
custom-kernel-custom-userspace world to one where you might be
upreving kernels and userspace separately, and you might be using an
older userspace with a newer machine and a newer kernel. Having to
update lscpu is an extra step and extra friction to making it behave
nicely.

There's also a growing expectation of the system to behave more like
x86, especially when it comes to trivial ways of detecting what kind
of machine you are running on. On x86 it's been trivial to look at
/proc/cpuinfo since it is provided by the platform there. Nobody wants
to change their implementation from having to read a file to exec a
program, dealing with errors, and parsing its output (sure, easier
from scripts, but more awkward from real source).

Having the information exported from the kernel is a reasonable way to
do it. The other extreme is that the kernel should just ever have
exported the raw MIDR value.


-Olof
