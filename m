From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Jul 2013 15:04:51 +0100
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <1375192570.32691.27.camel@kazak.uk.xensource.com>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
 <20130729135000.GK32383@mudshark.cambridge.arm.com>
 <1375106635.12741.8.camel@kazak.uk.xensource.com>
 <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
 <1375192570.32691.27.camel@kazak.uk.xensource.com>
Message-ID: <20130730140451.GQ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 02:56:10PM +0100, Ian Campbell wrote:
> Actually I've just noticed that the existing text in
> Documentation/arm/Booting only talks about zImage and 32KiB, so perhaps
> not worrying about non-zImage is acceptable?

Straight binary kernels have tighter requirements, because they're _not_
entirely position independent.  Firstly, with dynamic physical offset,
they calculate that based on their position in physical space when
they're first called.

So, with a PAGE_OFFSET of 0xc0000000 and a link address of 0xc0008000,
a binary kernel image better be placed at 0xXXXX8000, and it _will_
assume that RAM starts 32KiB below itself.  And yes, the 32KiB offset
applies as the kernel uses TEXTADDR-16KiB to store the initial page
tables.
