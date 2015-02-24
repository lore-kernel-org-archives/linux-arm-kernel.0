From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Feb 2015 10:43:40 +0000
Subject: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack, soft
 lockups and hard lockups
In-Reply-To: <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <20150224063513.GA15387@gmail.com>
 <CADyApD06_0uf4QgGVWRQyBP9pb2VRQnCOGK7M7K9kTti52usoQ@mail.gmail.com>
Message-ID: <20150224104339.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 01:39:46AM -0800, Arjan van de Ven wrote:
> one of the question is if you want to serialize, or if you just want
> to label.  If you take a cookie (could just be a monotonic increasing
> number) at the start of the oops and then prefix/postfix the stack
> printing with that number, you don't serialize (risk of locking up),
> but you can pretty trivially see which line came from where..
> if you do the monotonic increasing number approach, you even get an
> ordering out of it. it does mean changing the dump_stack() and co
> function fingerprint to take an extra argument, but that is not TOO
> insane.

I like that idea, but it relies on ensuring that each line is printed
by one printk() statement - which in itself is a good idea.

I'd actually like a version of print_hex_dump() which we could use for
stack and code dumping - the existing print_hex_dump() assumes that it's
fine to dereference the pointer, whereas for stack and code dumping,
we can't always make that assumption.  That's a separate issue though.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
