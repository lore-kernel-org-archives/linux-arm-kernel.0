From: joe@perches.com (Joe Perches)
Date: Tue, 05 Jun 2012 17:19:31 -0700
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <CAPXgP12OFnh6FZO4zFGCw=Ea4U6Ne5OoCg_9BPxRX62x0EVnng@mail.gmail.com>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
 <20120605162910.caccb0d4.akpm@linux-foundation.org>
 <1338939316.11962.3.camel@joe2Laptop>
 <CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
 <1338939792.11962.4.camel@joe2Laptop>
 <CAPXgP10DEsqtz9xbPUQ3xCwdFGTTYyTGSd7yEcU2vUr3SJ83Sw@mail.gmail.com>
 <1338940345.11962.9.camel@joe2Laptop>
 <20120605165808.cd255b93.akpm@linux-foundation.org>
 <1338941247.11962.16.camel@joe2Laptop>
 <CAPXgP12OFnh6FZO4zFGCw=Ea4U6Ne5OoCg_9BPxRX62x0EVnng@mail.gmail.com>
Message-ID: <1338941971.11962.20.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-06 at 02:13 +0200, Kay Sievers wrote:
> The question is what happens if you inject your new binary two-byte
> prefix, like:
>   echo -e "\x01\x02Hello" > /dev/kmsg

It's not a 2 byte binary.
It's a leading ascii SOH and a standard ascii char
'0' ... '7' or 'd'.

#define KERN_EMERG	KERN_SOH "0"	/* system is unusable */
#define KERN_ALERT	KERN_SOH "1"	/* action must be taken immediately */
etc...

> And if that changes the log-level to "2" instead of the default "4"?

No it doesn't.

It's not triggering that because devkmsg_writev does
prefix parsing only on the old "<n>" form.
