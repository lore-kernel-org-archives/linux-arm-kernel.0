From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 28 Nov 2013 09:29:34 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
Message-ID: <20131128092933.GA8642@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 01:04:23PM +0530, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> This patch series provides an implementation of supporting 48-bit
> Physical Addresses for ARMv8 platforms. It is the maximum width that
> any ARMv8 based processor can support. 
> 
> The implementation extends the existing support of 40-bit PA.The kernel
> and user space will now be able to access 128TB each. With 4KB page size
> the Linux now will be using 4 levels of page tables by making use of
> 'pud'. And with 64KB page size the Linux will be using 3 levels of page
> tables.
> 
> The code has been tested with LTP.

Hello,

Could you please test how this series interacts with huge pages?
So please run LTP with THP enabled and always active:
  TRANSPARENT_HUGEPAGE=y
  TRANSPARENT_HUGEPAGE_ALWAYS=y
(for both 4KB and 64KB base page sizes).
This will give the pmd level code a workout.

Then could you please try libhugetlbfs to test HugeTLB?
  git://git.code.sf.net/p/libhugetlbfs/code (next branch)
with the following enabled:
  HUGETLBFS=y

Please run the test suite against 2MB, 1GB (4KB base pages) and 512MB
(64KB base pages) huge pages.

To set aside 1GB huge pages at boot time, please add the following to
the kernel command line:
  hugepagesz=1G hugepages=x
where x is the number of 1GB huge pages you can get away with :-).

For 2MB and 512MB:
  echo x > /proc/sys/vm/nr_hugepages
again where x is the number of huge pages to set aside.

Ensure that the hugetlbfs filesystem is mounted:
  mount -t hugetlbfs hugetlbfs /mnt/hugepages

Then
  make check

The libhugetlbfs tests above will test out the pud and pmd interactions,
please let me know whether or not anything breaks.

Thanks,
-- 
Steve
