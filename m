From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 15:11:25 +0000
Subject: [PATCH 1/1] arm: vfp: Raising SIGFPE on invalid floating point
 operation
In-Reply-To: <CAFPAmTQ+XfBUQD2cr6WV04ndWji4zFhaOwvVVi8NaunH3TpkSA@mail.gmail.com>
References: <1328258184-23082-1-git-send-email-consul.kautuk@gmail.com>
 <20120203132717.GB2098@linaro.org>
 <CAFPAmTQ+XfBUQD2cr6WV04ndWji4zFhaOwvVVi8NaunH3TpkSA@mail.gmail.com>
Message-ID: <20120203151125.GL889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 08:07:02PM +0530, Kautuk Consul wrote:
> The **E bits(DZE/IOE/etc) are non-programmable on my system and they
> are set to 0
> however I try to play with them.

If the E bits are always zero, your VFP is incapable of _signalling_
the corresponding exception conditions.  Or, to put it another way,
those exception conditions are always masked.

And, if DZE is always zero, which is the divide-by-zero exception, then
obviously it won't raise an exception when you _do_ ask it to divide by
zero.  Instead, it will just set the cumulative exception status.

And, again, obviously, if it doesn't raise an exception, there is no
way for the system to deliver a SIGFPE to the user process.

Userspace does need to deal with this - as Dave points out, having
feenableexcept() return an error of the *E bits can't be set would
seem to be the sensible thing to do.  Whether or not user programs
even use that call (most, I suspect don't) is a separate problem.
