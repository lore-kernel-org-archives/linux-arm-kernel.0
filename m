From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 08:17:01 +0100
Subject: ptrace(PTRACE_PEEKUSER, ..., PT_TEXT_ADDR, ...)
In-Reply-To: <20100820124118.GC6950@richter>
References: <20100820124118.GC6950@richter>
Message-ID: <20100901071701.GC8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 02:41:28PM +0200, Simon Richter wrote:
> when patching gdbserver to work on MMUless ARM systems I found that
> there are two definitions for the magic values for PT_TEXT_ADDR (and the
> related fields) in different Linux versions. uClinux 2.4 kernels use
> values starting from 0xc4 (the same as the Coldfire port), while 2.6
> based kernels use magic numbers starting from 0x10000, which were
> introduced in 68b7f7153fa58df710924fbb79722717d2d16094 .
> 
> As has been pointed out by Andreas Schwab from SuSE, the code
> responsible for returning the text segment address is never reached
> because the lines immediately before the code added in the commit
> already filter these out and return -EIO.

I've always regarded this PT_* stuff as a hack around the problem at
hand - and as you point out below...

> So apparently the new values have never really been in use (so I
> wouldn't consider them part of the kernel interface), and the old values
> now point to something else (because VFP registers were added to struct
> user).

... it has the potential to break horribly when the original API is
extended through additional hardware features.

Maybe this is something which should be fixed properly by introducing
a proper cross-arch API for getting this information.
