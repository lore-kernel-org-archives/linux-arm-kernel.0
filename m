From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 15:21:53 +0100
Subject: linux-3.4-rc1 PXA2xx PCMCIA possible regression
In-Reply-To: <1333547721.81557.YahooMailClassic@web29008.mail.ird.yahoo.com>
References: <20120404130803.GV24211@n2100.arm.linux.org.uk>
 <1333547721.81557.YahooMailClassic@web29008.mail.ird.yahoo.com>
Message-ID: <20120404142153.GX24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 02:55:21PM +0100, Paul Parsons wrote:
> It is languishing in pending patch land:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089266.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/088988.html

These links aren't working for me at the moment.  I found the patches
in my mailbox nevertheless.

As you're using the PXA stuff, that selects PCMCIA_SOC_COMMON, which means
this part of Rob's patch is rubbish, because you'll get the 4GB IO space
precisely because of PCMCIA_SOC_COMMON being enabled.

 #ifndef IO_SPACE_LIMIT
-#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
+#if defined(CONFIG_PCCARD)
 #define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
-#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
+#elif defined(CONFIG_PCI) || defined(CONFIG_ISA)

So it all hinges around what we supply for the __io() macro.
