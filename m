From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Mon, 10 Feb 2014 17:36:06 +0100
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140210152452.GA26684@n2100.arm.linux.org.uk>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140210141634.GA2794@e103592.cambridge.arm.com> <52F8E5E2.30805@st.com>
 <20140210151247.GD2794@e103592.cambridge.arm.com>
 <20140210152452.GA26684@n2100.arm.linux.org.uk>
Message-ID: <52F8FFF6.80400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/10/2014 04:24 PM, Russell King - ARM Linux wrote:
> On Mon, Feb 10, 2014 at 03:12:47PM +0000, Dave Martin wrote:
>> Firstly, blindly adding 4 to PC is obviouly not right, partly because we
>> might be running an unrelated thread by the time the abort fires, and
>> also because the affected instruction might not be 4 bytes in size in a
>> Thumb kernel.
> Exactly.  We ended up on some platforms having special accessors for PCI
> where we included a number of 'mov r0, r0' instructions after the accessor
> so we could properly cope with them - but this required knowledge that
> we were going to only receive an imprecise abort from these accessors
> and only for a few cycles after the instruction.
>
> However, that's not true with modern architectures.  The point they're
> received will _not_ be the load/store which resulted in the abort, and
> in the case of a write, they could be many hundreds of cycles later,
> especially if the write has been buffered.
What about putting a memory barrier after a load/store ?
CPU should wait for the operation to complete right ?
>
> So adding four to the PC is definitely a very /bad/ thing to do.
>
