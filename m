From: jeffrey.hundstad@mnsu.edu (Jeffrey Hundstad)
Date: Wed, 11 Aug 2010 11:16:50 -0500
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <1281542305.5107.11.camel@localhost>
References: <4C5F9B25.8080401@st.com>	
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>	
	<4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
	<1281542305.5107.11.camel@localhost>
Message-ID: <4C62CCF2.5040206@mnsu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2010 10:58 AM, David Woodhouse wrote:
 > On Wed, 2010-08-11 at 10:46 -0500, Jeffrey Hundstad wrote:
 >> Exchange 2010 does not handle IMAP "chunking" (partial message transfer)
 >> correctly.  Any request after about 1 megabyte of total message size
 >> will fail.
 >>
 >> Thunderbird uses this "chunking" feature to give you a status update
 >> while downloading large messages.  The IMAP statements are of this type:
 >> 11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)
 >>
 >> When the 20480 is larger than 1MB Exchange "claims" there is no more.
 >> Sigh....
 >
 > I think the problem is not with the fetching -- the problem is that
 > Exchange lies about RFC822.SIZE before the IMAP client even starts to
 > fetch the message. It reports a size which is smaller than the actual
 > size of the message, thus leading to truncated fetches.
 >
 > In Evolution we have a workaround -- we don't just stop when we get to
 > the reported RFC822.SIZE; we continue fetching more chunks until the
 > server actually stops giving us any more. It's not as efficient (because
 > we fall back to having only one more chunk outstanding at a time rather
 > than the normal three in parallel), but at least it works around this
 > brokenness of Exchange.
 >
 > http://git.gnome.org/browse/evolution-data-server/commit/?id=9714c064
 >

In either case it can be used successfully by disabling 
mail.server.default.fetch_by_chunks in Thunderbird.

-- 
Jeffrey Hundstad
