From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Aug 2012 09:58:19 +0100
Subject: [PATCH v2 23/31] arm64: Debugging support
In-Reply-To: <201208202010.59985.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <20120820090754.GB25864@mudshark.cambridge.arm.com>
 <20120820092744.GD25864@mudshark.cambridge.arm.com>
 <201208202010.59985.arnd@arndb.de>
Message-ID: <20120821085819.GD28660@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 09:10:59PM +0100, Arnd Bergmann wrote:
> On Monday 20 August 2012, Will Deacon wrote:
> > On Mon, Aug 20, 2012 at 10:07:54AM +0100, Will Deacon wrote:
> > > On Fri, Aug 17, 2012 at 08:06:07AM +0100, Arnd Bergmann wrote:
> > > > Sorry for the dumb question, but why do you even need PTRACE_GET_THREAD_AREA
> > > > for 64 bit tasks? I thought the thread pointer is a GPR, or is this just
> > > > for compat tasks?
> > > 
> > > The TLS is stored in a co-processor register which is read-only for
> > > userspace.
> > 
> > I should elaborate: the register is RW for AArch64 tasks, RO for aarch32
> > tasks (although that doesn't affect the need for the ptrace request).
> 
> So can't you just /add/ that register to the GPR regset?

We *could*, but it doesn't feel right to me. The TLS register:

	- Can only be manipulated by msr/mrs instructions
	- Is not part of the PCS
	- Is not accessed explicitly by user applications
	- Can not be written via ptrace

so I think it sticks out like a sore thumb if we bundle it up with the GPRs.

Will
