From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 16:35:48 +0100
Subject: [PATCH v2] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <E0CBFB71-15B1-4C83-8B97-AF1C5CA48B98@smart-africa.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <1432821287-31436-1-git-send-email-michael@smart-africa.com>
 <CACRpkdY4sZQr+VzMKzU2Rtm7sP2zMztBioCPQRJjq=VjyapAEA@mail.gmail.com>
 <20150602145254.GE2067@n2100.arm.linux.org.uk>
 <E0CBFB71-15B1-4C83-8B97-AF1C5CA48B98@smart-africa.com>
Message-ID: <20150602153548.GG2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 05:21:11PM +0200, Michael van der Westhuizen wrote:
> It?s almost depressing how quickly you grokked that!

Quite simple really:

$ cat > t.s
.word 0xee190f11
.word 0xee190f31
$ arm-linux-as -o t.o t.s
$ arm-linux-objdump -d t.o
...
00000000 <.text>:
   0:   ee190f11        mrc     15, 0, r0, cr9, cr1, {0}
   4:   ee190f31        mrc     15, 0, r0, cr9, cr1, {1}

Those two words being the values which fit the word and mask you
specified, omitting the usual location for Rd (which is normally bits
12:16 in ARM instructions).  Of course, a couple more words would
confirm that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
