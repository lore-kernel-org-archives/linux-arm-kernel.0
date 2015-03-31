From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Mar 2015 10:13:29 +0100
Subject: [PATCH RFC 09/11] sound/core: add IEC958 channel status helper
In-Reply-To: <551A5B2F.50203@rock-chips.com>
References: <20150330193911.GM24899@n2100.arm.linux.org.uk>
 <E1YcfYA-0002vc-Al@rmk-PC.arm.linux.org.uk>
 <551A5B2F.50203@rock-chips.com>
Message-ID: <20150331091329.GP24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 04:30:39AM -0400, Yang Kuankuan wrote:
> >+	cs[0] = IEC958_AES0_CON_NOT_COPYRIGHT | IEC958_AES0_CON_EMPHASIS_NONE;
> >+	cs[1] = IEC958_AES1_CON_GENERAL;
> >+	cs[2] = IEC958_AES2_CON_SOURCE_UNSPEC | IEC958_AES2_CON_CHANNEL_UNSPEC;
> >+	cs[3] = IEC958_AES3_CON_CLOCK_1000PPM | fs;
> >+
> 
> Pretty good, also suitable to rockchip platform, but why not add the
> "IEC958_AES2_CON_CHANNEL_MASK" & "IEC958_AES2_CON_WORDLEN" ?
> 
> Seems sample frequency & channle number & word length are the basic
> message :)

I was debating about the word length, and that's something I'll add
later to it - but only if length shows that we have the 5th byte
available in the buffer.  Most users seem to only use the first four
bytes.

As for the channel number, this is intentionally left to the driver -
most cases I've found either the driver isn't interested, or where
they are interested (the only case I know of is my dw_hdmi ahb audio
driver), it's more appropriate to generate a baseline channel status,
and let the driver iterate over the channels adding the appropriate
channel number in.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
