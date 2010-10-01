From: ibr@radix50.net (Baurzhan Ismagulov)
Date: Fri, 1 Oct 2010 10:49:48 +0200
Subject: USB Mass Storage write problem
In-Reply-To: <20101001160035.7c67e481@morgan>
References: <20101001160035.7c67e481@morgan>
Message-ID: <20101001084948.GC5214@radix50.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 04:00:35PM +0800, Morgan Howe wrote:
> During the test process nothing will ever report failure, however,
> after the test completes, doing an MD5 check of the files will show
> that some files were not written properly.  The file sizes are all
> correct, but checking the contents we can see that in the bad files, at
> some arbitrary point in the file it will stop writing the actual data
> and the rest of the file will just be zero-filled.  The subsequent files
> after the bad one will be perfectly fine for a while (usually >1GB
> worth of files) and then randomly another file will get corrupted in
> this manner.  Using 2 16GB SD cards we usually see around 2-6 bad files
> for a full test run (until disk full).  We have tested this in both the
> 2.6.22.6 kernel and 2.6.35.
> 
> Has anyone experienced anything like this or have some idea where to
> look?

I had a somewhat similar problem which turned out to be floating DMA
control lines of the USB controller, which resulted in incorrect reads
from and writes to the flash on the CPU bus.

In your case, I'd disable all drivers that are not used in the test case
and repeat the test.

The next step could be tracing the lowest-level writing routine in the
kernel in order to see whether it is called at all, gets the right data
(e.g., you could generate a file that has the same checksum for every
block written, etc.) and correctly handles status information from the
hardware.

If this is also doesn't reveal the problem, logic analyzer could help to
see what happens in the hardware and to compare good and bad writes.

That said, such problems are often hard to find systematically.
Sometimes testing different configurations, hardware, etc. helps better;
for example, do you have a configuration that passes your test?

With kind regards,
-- 
Baurzhan Ismagulov
http://www.kz-easy.com/
