From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Oct 2016 19:04:08 +0100
Subject: [PATCH] arm64: Neaten show_regs, remove KERN_CONT
In-Reply-To: <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
References: <4cbf196b83cd9d175634e7056744dc649ae87f63.1477253239.git.joe@perches.com>
 <20161024113131.GH15620@leverpostej>
 <1477326477.1984.2.camel@perches.com>
 <20161024164255.GN15620@leverpostej>
 <CA+55aFwFQSass91gdGsjo4BkkAYmoFSn-Cpm6yF+SygF_tRp1g@mail.gmail.com>
Message-ID: <20161025180408.GF8898@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 10:38:31AM -0700, Linus Torvalds wrote:
> On Mon, Oct 24, 2016 at 9:42 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > That does not appear to be the case; as fr as I can tell the core prints a
> > timestamp per line as required. If I run:
> >
> >         printk("TEST\nLINE1\nLINE2\nLINE3\nLINE4\n");
> 
> Please don't do this.
>
> It has historically not worked well, and it still doesn't actually
> work reliably. In particular, it currently works in the *logs* (ie
> dmesg), but not necessarily on screen (because "msg_print_text()" does
> do the "look for newlines in the middle", but console_cont_flush()
> does not).

Sure; I'll avoid that.

it seems that's a drop in the ocean, though. :/

[mark at leverpostej:~/src/linux]% git grep 'pr\(intk\|_.*\)(.*)' | grep '\\n[^"]' | wc -l 
375

> So you can try the attached patch. It likely fixes your issues simply
> because it removes all the crazy code.

That worked for me. I see consistent results over the UART and in dmesg
with that applied atop of v4.9-rc2. Feel free to add:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
