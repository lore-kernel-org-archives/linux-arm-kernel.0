From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 20:40:52 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100421191600.GO27575@shareable.org>
References: <000001cae074$1b564ff0$4044010a@Emea.Arm.com>
	<20100420142047.GA7398@desktop>
	<20100420170944.GE2234@trinity.fluff.org>
	<20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421124317.GA9408@desktop>
	<000101cae16c$b2d08cd0$4044010a@Emea.Arm.com>
	<20100421191600.GO27575@shareable.org>
Message-ID: <20100421194052.GE26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 08:16:00PM +0100, Jamie Lokier wrote:
> The two-liner proposed earlier should fix all ARMs doing userspace
> execution > TASK_SIZE - the problem which started this thread.  But
> not kernel space accidentally executing an NX page > TASK_SIZE due to
> some bug, which can only occur on ARMv6/v7 due to NX.

Sorry James, that's wrong.  ARMv6 and ARMv7 use the IFSR, which gives
us the error code - and that distinguishes between a translation fault
and a permission fault.  An attempt to execute a NX page generates a
permission fault, and therefore we end up calling do_page_fault() rather
than indirecting via do_translation_fault().
