From: tony.luck@gmail.com (Tony Luck)
Date: Mon, 9 Jun 2014 15:25:37 -0700
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <20140503221658.GA13403@kroah.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
 <20140503220731.GA10927@kroah.com>
 <20140503221658.GA13403@kroah.com>
Message-ID: <CA+8MBb+7f1bOnJjJWj1vxa0UNuQwz7OGRDR_QFTxOT=9cynabQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 3, 2014 at 3:16 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>> > >>  drivers/tty/serial/8250/8250_early.c | 138 ++++-------------------------------
>> > >>  drivers/tty/serial/8250/Kconfig      |   1 +
>> > >>  2 files changed, 16 insertions(+), 123 deletions(-)
>> > >
>> > > Hi Greg, Rob
>> > >
>> > > This one in tty-next breaks booting: "console=uart8250,io,0x3f8,115200".
>> > > No early console and regular console anymore.
>> > >
>> > > It should produce "early con and regular con".
>> >
>> > This is what I get for running checkpatch and converting
>> > simple_strtoul to kstrto* which are not so equivalent. kstrto* will
>> > not convert things such as 115200n8 to a number.
>> >
>> > Greg, Do you want a fix or for me to respin the series? The fix looks like this:
>>
>> As this is in my tree now (right?), I need a fix to apply to it.
>
> Nevermind, you already sent it...

Linus' tree (HEAD=963649d735c8) is spitting out all sorts of garbage
on the serial console - as if the baud rate is being periodically set
to something weird, and then back to 112500.  I see over a dozen
blocks of junk interspersed with good output.

This in on ia64 with "console=uart,io,0x3f8" on the command line.

git bisect pointed me here:

d2fd6810a823bcde1ee232668f5689837aafa772 is first bad commit
commit d2fd6810a823bcde1ee232668f5689837aafa772
Author: Rob Herring <robh@kernel.org>
Date:   Fri Apr 18 17:19:56 2014 -0500

    tty/serial: convert 8250 to generic earlycon

-Tony
