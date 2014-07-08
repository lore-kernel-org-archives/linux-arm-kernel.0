From: pavel@denx.de (Pavel Machek)
Date: Tue, 8 Jul 2014 14:04:32 +0200
Subject: [PATCHv7 3/3] edac: altera: Add EDAC support for Altera SoC
 SDRAM Controller.
In-Reply-To: <20140708115458.GC27659@pd.tnic>
References: <1403730927-16163-1-git-send-email-tthayer@altera.com>
 <1403730927-16163-4-git-send-email-tthayer@altera.com>
 <20140708113109.GC8100@amd.pavel.ucw.cz>
 <20140708114227.GB27659@pd.tnic>
 <20140708115205.GA8628@amd.pavel.ucw.cz>
 <20140708115458.GC27659@pd.tnic>
Message-ID: <20140708120432.GB8628@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-07-08 13:54:58, Borislav Petkov wrote:
> On Tue, Jul 08, 2014 at 01:52:05PM +0200, Pavel Machek wrote:
> > I'm not joking. Try to understand and verify the code above. You
> > can't. The "descriptive macro names" are useless; all the code does is
> > split register in pieces. With the numbers it would be  very obvious.
> 
> No, you need to fix the names not switch to naked numbers.

Hiding numbers that are used just once into defines to put them out of
sight does not really help readability.

Compare:

+#define DRAMADDRW_COLBIT_MASK	0x001F
+#define DRAMADDRW_COLBIT_LSB	0
+#define DRAMADDRW_ROWBIT_MASK	0x02E0
+#define DRAMADDRW_ROWBIT_LSB	5
+#define DRAMADDRW_BANKBIT_MASK	0x1C00
+#define DRAMADDRW_BANKBIT_LSB	10
+#define DRAMADDRW_CSBIT_MASK	0xE000
+#define DRAMADDRW_CSBIT_LSB	13

(Insert few screens of code so that you have to scroll or split
window).

What information do the define names have? None, I already know how
hardware registers work.

+	col = (read_reg & DRAMADDRW_COLBIT_MASK) >>
+	     DRAMADDRW_COLBIT_LSB;
+	row = (read_reg & DRAMADDRW_ROWBIT_MASK) >>
+	     	 DRAMADDRW_ROWBIT_LSB;
+	bank = (read_reg & DRAMADDRW_BANKBIT_MASK) >>
+		      DRAMADDRW_BANKBIT_LSB;
+	cs = (read_reg & DRAMADDRW_CSBIT_MASK) >>
+		      	 DRAMADDRW_CSBIT_LSB;

Instead, we could have:

	 col = read_reg & 0x001F;
	 row = (read_reg & 0x02E0) >> 5;
	 bank = (read_reg & 0x1C00) >> 10;
	 cs = (read_reg & 0xE000) >> 13;

All information is preserved, code is shorter and easier to understand.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
