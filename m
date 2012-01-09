From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 9 Jan 2012 16:12:51 +0100
Subject: [PATCH 10/14] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
In-Reply-To: <20120108102533.GA21765@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com>
 <20120108102533.GA21765@n2100.arm.linux.org.uk>
Message-ID: <4F0B03F3.4020005@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:56PM +0100, Ulf Hansson wrote:
>> Instead of reading a register value everytime we need to
>> apply a new value for it, maintain a cached copy for it.
>> This also means we are able to skip writes that are not
>> needed.
> 
> I'm not sure this is a good idea.  The ARM Primecells require a certain
> number of bus clocks and MCLK periods between writes to both these
> registers, and reading them back helps to ensure that we conform to
> that requirement.  Maintaining a cached copy of them allows faster
> writes to these registers which could cause that requirement to be
> violated.

I were just about to update my patch according to your proposal, when I 
realized the only place were the registers were previously "read before 
write", were at an SDIO corner case in pio_write.

Earlier the register values were always written, without considering the 
old value. Thus the impact with this patch is kind of only decreasing 
the number of writes and affects a corner case for SDIO.

Do you anyway prefer to add a register "read before write" even if it 
never has been needed before?

> 
> What you could do is read the register, modify, and check whether the
> modification has had any effect before writing it back.  That will
> allow unnecessary writes to still be skipped.
> 

Sorry for spamming you.

BR
Ulf Hansson
