From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 29 Mar 2016 14:22:29 -0400
Subject: Bad mode in undefined instruction handler detected
In-Reply-To: <20160329165940.GA19428@n2100.arm.linux.org.uk>
References: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
 <20160329165940.GA19428@n2100.arm.linux.org.uk>
Message-ID: <CAF_dkJA=4iqD=siV5RM7KTDfEQGtKc3G17E+C+K+-_hmneK4aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,
Thank you for your insights...

On Tue, Mar 29, 2016 at 12:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This is the stack state for the parent context, and since we don't have
> a backtrace (due to no frame pointer) this becomes guess work - frankly
> I'm not going to waste my time guessing, and at this point ask you to
> reproduce on a kernel _with_ frame pointers enabled.
>
> You should then get proper stack frames which will take some of the guess
> work out of working out what in the above stack dump are addresses and
> what isn't.
Hmmm... inexplicably, compiling with frame pointers enabled doesn't
seem to be an option for me :-(

My Kernel Hacking submenu (based on 4.1 branch of the linux-at91
kernel source tree) goes from

"Filter access to /dev/mem"
to
"Enable stack unwinding support (EXPERIMENTAL)"

with no option to set CONFIG_FRAME_POINTER in between.  Could that be
because FRAME_POINTER looks like:

config FRAME_POINTER
    bool
    depends on !THUMB2_KERNEL
    default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
    help
      If you say N here, the resulting kernel will be slightly smaller and
      faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
      when a problem occurs with the kernel, the information that is
      reported is severely limited.

-- that is, not prompt for the "bool" option?  Is this an either/or
choice for ARM_UNWIND vs FRAME_POINTER?

I'm going to try adding a prompt for FRAME_POINTER in my tree and see
that gives me the ability to enable it.

--wpd
