From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 22 Jun 2011 14:41:38 +0300
Subject: [RFC 0/8] Introducing a generic AMP/IPC framework
In-Reply-To: <201106211620.02065.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<201106211620.02065.arnd@arndb.de>
Message-ID: <BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jun 21, 2011 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This looks really nice overall, but I don't currently have time for a
> more in-depth review. My feeling is that you are definitely on the right
> track here, and the plans you list as TODO to continue are all good.

Thanks !

> One point I noticed is the use of debugfs, which you should probably
> replace at some point with a stable API, e.g. your own debugfs-like
> file system, but there is no hurry to do that now.

debugfs is only being used to expose debugging info (namely the power
state of the remote processor and its trace log messages), which is
mostly useful for developers trying to understand what went wrong.

It seems like debugfs fits quite nicely here (e.g. it's perfectly fine
if this is completely compiled out on production systems), but sure,
we can always revisit this later too.

> Regarding the firmware, I think it would be nice to have the option
> to stick the firmware blob into the flattened device tree as a bininclude,
> so you can build systems using the external processors without special
> user space support.

That's interesting. we'll definitely explore this - thanks !

I was also hoping that DT will simplify remote resource allocations as
well (just like any other device, remote processors usually needs some
hw resources) and planned to try it out soon to see how it all works
out together. It might completely eliminate the preliminary "resource
section" thingy we have in the firmware structure currently.

> The binary format looks reasonable, but if you need anything more complex,
> you should probably go straight for ELF files ;-)

Hopefully we won't need to :)

> +struct fw_section {
> + ? ? ? u32 type;
> + ? ? ? u64 da;
> + ? ? ? u32 len;
> + ? ? ? char content[0];
> +} __packed;
>
> Unfortunately require __packed. It would be better to sort the members
> differently so that each member is naturally aligned in order to
> avoid the need for padding or __packed attributes

Definitely. __packed is being used just to be on the safe side; we
didn't intend to introduce unnatural alignment intentionally. will be
fixed.

Thanks!
Ohad.
