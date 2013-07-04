From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Thu, 4 Jul 2013 16:58:52 +0200
Subject: SPI: DUAL/QUAD support
In-Reply-To: <20130704130017.GA25997@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
Message-ID: <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Johannes:

> Doesn't m25p80 need to use different commands (OPCODEs)
> for 2x and 4x speed?  It seems this change is incomplete.

Yes, there are usually different opcodes, and as far as I know, they are 
not supported by the m25p80 driver. It seems we are missing some 
background info here.

My guess is that the flash chip in question is configured to treat single 
mode opcodes as dual or quad mode commands (some chips support this), and 
that the SPI controller needs to be told, for each transfer, which mode to 
use.

E.g., you would send a READ command with the command bytes in single mode 
(t[0].bitwidth is missing in the patch) and the data bytes in dual or quad 
mode. No dummy bytes are used -- the SPI is running at slower speed.

This situation is certainly a bit special. To me, the patch looks like a 
short-time workaround; I would rather see the flash driver support actual 
dual or quad mode commands. Is there any work in progress?

Best regards,
Thomas
