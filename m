From: etienne.carriere@st.com (Etienne CARRIERE ST)
Date: Wed, 14 Nov 2012 11:40:31 +0100
Subject: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ
In-Reply-To: <20121114095121.GB10142@mudshark.cambridge.arm.com>
References: <0154077FE026E54BB093CA7EB3FD1AE32B57AF1B59@SAFEX1MAIL3.st.com>
 <20121113170711.GI28327@n2100.arm.linux.org.uk>
 <0154077FE026E54BB093CA7EB3FD1AE32B57AF1E29@SAFEX1MAIL3.st.com>
 <20121114095121.GB10142@mudshark.cambridge.arm.com>
Message-ID: <0154077FE026E54BB093CA7EB3FD1AE32DB61E4D16@SAFEX1MAIL3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I don't catch "swizzle your implementation" ?

You are referring to the raw_spinlock LOCKBREAK stuf ?
I will look deeper into linux code to check is some deadlock could appear.

The shared mutex arch spinlock is locked after raw_spinlick locking and released before l2x0 native raw_spinlock releasing.
It is intended to leave kernel preemption stuff inside the linux world.

etienne

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Wednesday, November 14, 2012 10:51 AM
To: Etienne CARRIERE ST
Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org; Marc Zyngier; Catalin Marinas; Linus Walleij; Rabin VINCENT; Srinidhi KASAGAR
Subject: Re: [PATCH 1/2] arm/mm: L2CC shared mutex with ARM TZ

On Wed, Nov 14, 2012 at 09:18:31AM +0000, Etienne CARRIERE ST wrote:
> This is why the mutex added for TZ shared of L2 cache maintenance is a "arch_spinlock". It assumes linux handles the spinlock as a native ARM native mutex DDR cell, handled from the ARMv7-A LDREX/STREX.
> I think this is the weakest part of the driver since they is no insurance that linux pristine arch_spinlock will not evolve into something else (i.e features in raw_spinclock).

How does this work with our ticket lock approach? Can you swizzle your locking implementation by inspecting the kernel version of the code running on the non-secure side? (I sincerely hope not...)

Will
