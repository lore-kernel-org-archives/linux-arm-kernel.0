From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 07 Mar 2017 19:56:15 +0000
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com> (Punit Agrawal's
 message of "Thu, 02 Mar 2017 18:28:47 +0000")
References: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
 <87wpc7o7mo.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <874lz4oo80.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Punit Agrawal <punit.agrawal@arm.com> writes:

[...]

>
> The code looks good but I ran into some failures while running the
> hugepages hwpoison tests from mce-tests suite[0]. I get a bad pmd error
> in dmesg -
>
> [  344.165544] mm/pgtable-generic.c:33: bad pmd 000000083af00074.
>
> I suspect that this is due to the huge pte accessors not correctly
> dealing with poisoned entries (which are represented as swap entries).

I think I've got to the bottom of the issue - the problem is due to
huge_pte_at() returning NULL for poisoned pmd entries (which in turn is
due to pmd_present() not handling poisoned pmd entries correctly)

The following is the call chain for the failure case.

do_munmap
  unmap_region
    unmap_vmas
      unmap_single_vma
        __unmap_hugepage_range_final    # The test case uses hugepages
          __unmap_hugepage_range
            huge_pte_offset             # Returns NULL for a poisoned pmd

Reverting 5bb1cc0ff9a6 ("arm64: Ensure pmd_present() returns false after
pmd_mknotpresent()") fixes the problem for me but I don't think that is
the right fix.

While I work on a proper fix, it would be great if you can confirm that
reverting 5bb1cc0ff9a6 makes the problem go away at your end.

>
> I am investigating the failure but could you try running the tests at
> your end as well.
>
> To run the tests, I cloned the repository[0]. It test needs a simple fix
> at the end of this mail to run correctly. With that applied and running
> as root -
>
> # cd mce-test/cases/function/hwpoison
> # ./run_hugepage.sh
>
>
> [0] https://git.kernel.org/cgit/utils/cpu/mce/mce-test.git/
>
> --------->8--------------
> commit cb5c61f18dd86baf01b90404d4ecf51dd3d176c7
> Author: Punit Agrawal <punit.agrawal@arm.com>
> Date:   Thu Mar 2 18:24:40 2017 +0000
>
>     Use correct return type for getopt_long
>
>     getopt_long returns an int. Fix the return type to avoid issues when
>     checking for negative error codes on architectures with unsigned char,
>     e.g., arm.
>
>     Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>
> diff --git a/cases/function/hwpoison/thugetlb.c b/cases/function/hwpoison/thugetlb.c
> index 92dc7d2..fbcf426 100644
> --- a/cases/function/hwpoison/thugetlb.c
> +++ b/cases/function/hwpoison/thugetlb.c
> @@ -125,7 +125,7 @@ int main(int argc, char *argv[])
>         int forkflag = 0;
>         int privateflag = 0;
>         int cowflag = 0;
> -   char c;
> + int c;
>         pid_t pid = 0;
>         void *expected_addr = NULL;
>         struct sembuf sembuffer;
