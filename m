From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 09:32:17 -0400 (EDT)
Subject: [RFC,
	PATCH 1/2] arm: don't check MMU status in every addruart macro
In-Reply-To: <1278903792.387860.948595132082.1.gpush@pororo>
References: <1278903792.387860.948595132082.1.gpush@pororo>
Message-ID: <alpine.LFD.2.00.1007120912450.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Jeremy Kerr wrote:

> Rather than checking the MMU status in every instance of addruart, do it
> once in kernel/debug.S, and change the existing addruart macros to
> expect the uart status in the macro argument register.
> 
> This will also allow us to retreive the address of a uart for the MMU
> state that we're not current in.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Many issues with this:

- __addruart vs addruart is rather confusing.  Normally the __xyz form 
  is used by the higher level xyz which is opposite to what is done 
  here.

- While at it, this should be replaced altogether by a macro that simply 
  returns both the physical address and the virtual address for the 
  debugging IO peripheral to use.  This would make your patch #2 much 
  straight forward too.

- The test to determine whether the MMU is active and select the 
  appropriate address to use should remain close together and actually 
  can be moved to a common place instead of being duplicated everywhere. 
  The code is really testing a specific bit in a hardware register, and 
  with this patch that now looks as if this was a simple boolean 
  argument which is not a good thing.


Nicolas
