From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 12:24:10 +0000
Subject: [RFC PATCH 3/3] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <1297426345.17584.99.camel@e102109-lin.cambridge.arm.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-4-git-send-email-ccross@android.com>
	<1297426345.17584.99.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110211122410.GF23404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 12:12:25PM +0000, Catalin Marinas wrote:
> On SMP systems, we save the VFP at every context switch to deal with the
> thread migration (though I have a plan to make this lazily on SMP as
> well).

I'm not sure it's worth the complexity.  You'd have to do an IPI to the
old CPU to provoke it to save the context from its VFP unit.  You'd have
to do that in some kind of atomic way as the old CPU may be in the middle
of already saving it.  You're also going to have to add locking to the
last_VFP_context[] array as other CPUs will be accessing non-local
entries, and that means doing locking in assembly.  Yuck.

No, let's not go there.  Stick with what we currently have which works
well.
