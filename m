From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Nov 2015 20:46:41 +0000
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <563CF510.9080506@redhat.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
 <563B81DA.2080409@redhat.com>
 <20151105162719.GQ8644@n2100.arm.linux.org.uk>
 <563BFCC4.8050705@redhat.com>
 <CAGXu5jLS8GPxmMQwd9qw+w+fkMqU-GYyME5WUuKZZ4qTesVzCQ@mail.gmail.com>
 <563CF510.9080506@redhat.com>
Message-ID: <20151106204641.GT8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 10:44:32AM -0800, Laura Abbott wrote:
> with my test patch. I think setting both current->active_mm and &init_mm
> is sufficient. Maybe explicitly setting swapper_pg_dir would be cleaner?

Please, stop thinking like this.  If you're trying to change the kernel
section mappings after threads have been spawned, you need to change
them for _all_ threads, which means you need to change them for every
page table that's in existence at that time - you can't do just one
table and hope everyone updates, it doesn't work like that.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
