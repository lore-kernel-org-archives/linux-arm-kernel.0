From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 20 Aug 2012 14:24:51 -0700
Subject: [PATCH v4 0/12] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <CANqkERCzQdViRjhtz19wbSWEEnxYjpDcuUZNP9jNHYrtANwp-g@mail.gmail.com>
References: <20120820144449.GA32560@lizard>
 <CANqkERCzQdViRjhtz19wbSWEEnxYjpDcuUZNP9jNHYrtANwp-g@mail.gmail.com>
Message-ID: <20120820212451.GA15823@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, Aug 20, 2012 at 01:51:33PM -0700, Brian Swetland wrote:
> > - KGDB/KDB FIQ debugger shell is synchronous. In Google's version you
> >   could have a dedicated shell always running in the FIQ context,
[...]
> The main reason we did this asynchronously was that it's entirely possible
> to get the occasional random character on the debug serial port (which is
> often multiplexed with the audio path on the headphone jack), and having
> the device freeze mysteriously when this happens is problematic.
> 
> Since the FIQ debugger is incredibly useful for diagnosing "my device is
> stuck" type problems, we tend to leave it enabled on large numbers of
> devices during internal testing, so that if somebody runs into a problem
> an engineer can plug in a serial debug cable and take a look.  It's
> important that the presence of the debug feature doesn't lead to instability,
> and thus we don't want a single random character to stop the normal
> operation ofthe device.

Yup, and that's why in my approach I implemented a tiny async "shell" on
to of KDB, the shell accepts just one command "$3#33" -- GDB-protocol
escape sequence:

/**
 * kgdb_nmi_poll_knock - Check if it is time to enter the debugger
 *
 * "Serial ports are often noisy, especially when muxed over another port (we
 * often use serial over the headset connector). Noise on the async command
 * line just causes characters that are ignored, on a command line that blocked
 * execution noise would be catastrophic." -- Colin Cross
 *
 * So, this function implements KGDB/KDB knocking on the serial line: we won't
 * enter the debugger until we receive a known magic phrase (which is actually
 * "$3#33", known as "escape to KDB" command.
 ...

I.e. the kernel will print this prompt on the NMI debugger console:

        Type $3#33 to enter the debugger>

And this command will be processed asynchronously.

Thanks!

Anton.
