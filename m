From: swetland@google.com (Brian Swetland)
Date: Mon, 20 Aug 2012 13:51:33 -0700
Subject: [PATCH v4 0/12] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <20120820144449.GA32560@lizard>
References: <20120820144449.GA32560@lizard>
Message-ID: <CANqkERCzQdViRjhtz19wbSWEEnxYjpDcuUZNP9jNHYrtANwp-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 7:44 AM, Anton Vorontsov
<anton.vorontsov@linaro.org> wrote:
>
> - KGDB/KDB FIQ debugger shell is synchronous. In Google's version you
>   could have a dedicated shell always running in the FIQ context, so
>   when you type something on a serial line, you won't actually cause any
>   debugging actions, FIQ would save the characters in its own buffer and
>   continue execution normally. But when you hit return key after the
>   command, then the command is executed.
>
>   In KGDB/KDB FIQ debugger it is different. Once you enter KGDB, the
>   kernel will stop until you instruct it to continue.
>
>   This might look as a drastic change, but it is not. There is actually
>   no difference whether you have sync or async shell, or at least I
>   couldn't find any use-case where this would matter at all. Anyways, it
>   is still possible to do async shell in KDB, just don't see any need
>   for this.

The main reason we did this asynchronously was that it's entirely possible
to get the occasional random character on the debug serial port (which is
often multiplexed with the audio path on the headphone jack), and having
the device freeze mysteriously when this happens is problematic.

Since the FIQ debugger is incredibly useful for diagnosing "my device is
stuck" type problems, we tend to leave it enabled on large numbers of
devices during internal testing, so that if somebody runs into a problem
an engineer can plug in a serial debug cable and take a look.  It's
important that the presence of the debug feature doesn't lead to instability,
and thus we don't want a single random character to stop the normal
operation ofthe device.

Brian
