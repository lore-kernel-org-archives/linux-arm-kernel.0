From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 11 Aug 2010 16:58:25 +0100
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <4C62C5BD.3020808@mnsu.edu>
References: <4C5F9B25.8080401@st.com>
	<AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	<4C624AE1.30504@st.com>  <4C62C5BD.3020808@mnsu.edu>
Message-ID: <1281542305.5107.11.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-08-11 at 10:46 -0500, Jeffrey Hundstad wrote:
> Exchange 2010 does not handle IMAP "chunking" (partial message transfer) 
> correctly.  Any request after about 1 megabyte of total message size 
> will fail.
> 
> Thunderbird uses this "chunking" feature to give you a status update 
> while downloading large messages.  The IMAP statements are of this type:
> 11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)
> 
> When the 20480 is larger than 1MB Exchange "claims" there is no more.  
> Sigh.... 

I think the problem is not with the fetching -- the problem is that
Exchange lies about RFC822.SIZE before the IMAP client even starts to
fetch the message. It reports a size which is smaller than the actual
size of the message, thus leading to truncated fetches.

In Evolution we have a workaround -- we don't just stop when we get to
the reported RFC822.SIZE; we continue fetching more chunks until the
server actually stops giving us any more. It's not as efficient (because
we fall back to having only one more chunk outstanding at a time rather
than the normal three in parallel), but at least it works around this
brokenness of Exchange.

http://git.gnome.org/browse/evolution-data-server/commit/?id=9714c064

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
