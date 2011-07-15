From: ccross@google.com (Colin Cross)
Date: Fri, 15 Jul 2011 15:13:57 -0700
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <20110715215819.GG24628@n2100.arm.linux.org.uk>
References: <CAMbhsRT=NNYUYyYZXpz2=PpBXoBGANQHPgOkCE1oZ8XzHKN4og@mail.gmail.com>
	<CAMbhsRSgUcFPpdTFvEDTFfo_Wk0k7BQzwk6cRtXC6K7mpQ+YDg@mail.gmail.com>
	<20110715080950.GL23270@n2100.arm.linux.org.uk>
	<CAMbhsRRCV0ukwbzFc6w_ba6xdVxs=TFmJMGd06UKTiNQPEJqpw@mail.gmail.com>
	<20110715161628.GA24628@n2100.arm.linux.org.uk>
	<CAMbhsRSbXTLzhSzBbQ8ebJqAC227ESHGyY2bHS+J4cN+NgzXFg@mail.gmail.com>
	<20110715181309.GD24628@n2100.arm.linux.org.uk>
	<CAMbhsRQRjwskzWB06g7rmSVgSdq5oVxA3yY+14qdtTxuQ=NeMQ@mail.gmail.com>
	<20110715210720.GF24628@n2100.arm.linux.org.uk>
	<CAMbhsRR=EVhKPkNUnzQ_2Ai9edWpmvHM_9TXwhh-xaa9Dk1Mcw@mail.gmail.com>
	<20110715215819.GG24628@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRSQpThghsO0X=i8g3MmyZC+cDJaOJ1+MYZV3hvw-8=GXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 2:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 15, 2011 at 02:18:59PM -0700, Colin Cross wrote:
>> The thread has devolved into a generic command line problem - how to
>> pass completely unrelated options from the bootloader to the kernel
>> without also having to pass in every other option that the kernel
>> requires to boot. ?I have a solution that works for my case
>> (CMDLINE_EXTEND), I was trying to offer a solution that would work for
>> me while also working for multi-board kernels, but I'm happy to drop
>> it.
>
> You miss the point.
<snip>

You cut out the relevant part of my email where I didn't miss your point:
>> My initial offer was a patch that makes an incorrect overlapping mem=
>> command line print a warning and ignore it, instead of doing something
>> that is guaranteed to crash the kernel in an obscure way.  I'll post a
>> patch.

I don't care about making overlapping mem= work, I'm just trying to
make it easier to debug when someone screws up and passes conflicting
mem= arguments, by printing a big warning.  When the warning is
printed, the kernel might as well take a stab at picking which of the
two mem= arguments might let it boot far enough to get the console up
- taking the smaller of any two overlapping regions seems most likely
to work.  If not, DEBUG_LL will show the warning.

The multiple command lines issue is irrelevant - I happened to hit
this using CMDLINE_EXTEND, I could just as well have put both mem=
options in ATAG_CMDLINE, and the problem would have been just as hard
to debug.
