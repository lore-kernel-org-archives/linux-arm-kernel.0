From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 11:47:33 +0530
Subject: [PATCH kexec-tools 04/32] kdump: fix kdump mapping
In-Reply-To: <E1axXSF-0004hH-Oo@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSF-0004hH-Oo@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GurQ44ybkxaYJJQeGgnuw=3tKOk7xyB6FTAursMLuZGrJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> When kdump tries to map the program header, it fails to take account
> of ehdr->e_phoff being an offset from the start of the ELF "file",
> which causes:
>
> Cannot mmap /dev/mem offset: 64 size: 392: Invalid argument
>
> Ensure that we take account of the start address when mapping this.
>
> This fix has been extracted from a larger patch by Vitaly Andrianov
> adding support for Keystone 2.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kdump/kdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 1f5b984..34d2149 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -284,7 +284,8 @@ int main(int argc, char **argv)
>         }
>
>         /* Get the program header */
> -       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), ehdr->e_phoff);
> +       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum),
> +                       start_addr + ehdr->e_phoff);

This is fine. But at the same time should n't we also fix the offset
for mmap of memory segments?  For memory segments, offset is
phdr[i].p_offset, and I do not see generate_new_headers() taking care
of start_addr.

>
>         /* Collect up the notes */
>         note_bytes = 0;
> --
> 1.9.1
>

~Pratyush
