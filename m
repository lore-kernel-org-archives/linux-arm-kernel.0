From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Jul 2011 12:36:25 +0100
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register
	of ARM v6 & v7 Architectures
In-Reply-To: <4E1ECDD4.1020800@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
	<a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
	<20110714100254.GA20903@e102144-lin.cambridge.arm.com>
	<4E1ECDD4.1020800@st.com>
Message-ID: <20110714113625.GB20903@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 12:07:00PM +0100, Wolfgang BETZ wrote:
> Ciao Will,

Hello,

> maybe there is a basic misunderstanding: do we speak about the actual CONTEXTID
> register or the data structures in the Linux kernel which represents this
> register?

Sorry, I didn't see that you'd changed the context ID writes so that they
write the masked value. I also looked to see if there's a handy thread ID
register you can use instead but there isn't (TPIDRRO is used for the TLS).

Looking again at the structure of your code (FrankH has already pointed out
a lot of the implementation issues), perhaps this would be better off as a
(configurable) thread notifier which reads the context ID, sets the upper
bits (taking care to preserve the ASID) and writes it back.

This is far less invasive, is easy to enable/disable and is also easy to
implement for future cores without requiring changes to older CPUs.

Would that work?

Will
