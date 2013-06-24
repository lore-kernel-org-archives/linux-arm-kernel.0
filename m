From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jun 2013 10:06:41 +0100
Subject: SCU registers mapping for CA9/CA5 cores
In-Reply-To: <201306211129.22625.arnd@arndb.de>
References: <CADApbei3QOCQRmo_oYZ_XiUVupq+4uUs7WNe6f7k_OG0LHB3=w@mail.gmail.com>
 <20130621081356.GU2718@n2100.arm.linux.org.uk>
 <201306211129.22625.arnd@arndb.de>
Message-ID: <20130624090640.GZ2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 11:29:22AM +0200, Arnd Bergmann wrote:
> I think we could actually move everything between VMALLOC_END and
> ffff0000 /into/ a larger fixmap. This would be a substantial change,
> but it would give us more vmalloc space for most configurations
> and more flexibility with what else we could put into fixmap.

... at the expense of:
(a) having to look up the PTE table pointer every time we want to add or
remove a mapping,
(b) wasting the top 15 pages from being used.

Also, the placement of some of these pages _matters_ especially for the
VIPT aliasing caches, where cache colouring becomes important.  So an
enum in fixmap isn't going to work for those.

Really, the value to such a change is very low and is really just churn
for churn's sake.  "Oh we can do something different!"  No.
