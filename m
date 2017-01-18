From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 18 Jan 2017 17:58:05 +0000
Subject: [PATCH] arm64: defconfig: disable CONFIG_DEVMEM
In-Reply-To: <20170115124254.GF25883@bivouac.eciton.net>
References: <20170113113734.16524-1-leif.lindholm@linaro.org>
 <20170113114801.GD3253@arm.com> <20170115124254.GF25883@bivouac.eciton.net>
Message-ID: <CAF7UmSxMqKodEZfqheRsJxsM_R1yZHJaXMnyLyJwqULRz1xH=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2017 at 12:42, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Fri, Jan 13, 2017 at 11:48:01AM +0000, Will Deacon wrote:
>> On Fri, Jan 13, 2017 at 11:37:34AM +0000, Leif Lindholm wrote:
>> > /dev/mem is the opposite of what an operating system is for.
>> > Additionally, on arm* it opens up for denial-of-service attacks from
>> > userspace. So leave it disabled by default, requiring people who need
>> > it to enable it explicitly.
>>
>> I really like the idea, but are we sure that nothing common breaks without
>> this? For example, does Debian still boot nicely with this patch applied?
>
> Getting distros to not have to shop around for config fragments in
> order to be able to a stable system is one of my main purposes of this
> patch.
>
> Since Debian just published a 4.9 kernel, I gave that a spin (both DT
> and ACPI). No issues.

Will, any comments?

/
    Leif

>> Just trying to get a feel for how much userspace this has seen (particularly
>> on ACPI-based systems, which I seem to remember like poking about in here).
>
> There are various tools that let you figure out various things about
> the system (a bit like running dtc on a dump of the active
> device-tree), but nothing actually used for booting a system (much
> like dtc).
>
> /dev/mem has been used for things like dmidecode and acpidump in the
> past, but we fixed those tools back in 2015 to use /sys interfaces
> instead of blindly groping around and hoping for the best.
>
> Stretch version of dmidecode operates as expected on both DT and ACPI
> boot, and acpidump does in the ACPI case (no tables in /sys otherwise).
>
> There may be other tools that will also break if not implementing
> support for access via /sys, but none critical for system operation
> (and currently a denial-of-service waiting to happen anyway).
>
> Systemd will try to access /dev/mem to extract boot timestamp stuff,
> but handles a failure gracefully (i.e. not even a warning message).
