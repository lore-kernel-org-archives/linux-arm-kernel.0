From: msalter@redhat.com (Mark Salter)
Date: Mon, 12 Aug 2013 10:02:40 -0400
Subject: [PATCH V3 RFC 00/16]  EFI stub for ARM
In-Reply-To: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
Message-ID: <1376316160.32237.17.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-09 at 16:26 -0700, Roy Franz wrote:
> * Change FDT memory allocation to retry with a larger allocation if
>   first educated guess is inadequate.

With this change, it looks like you no longer free the original cmdline
and fdt memory. The current flow looks like:

  retry:
     allocate_memory_for_expanded_fdt
     get_memory_map
     if (update_fdt() fails) {
        free new_fdt and memory_map
        goto retry
     }

So, this keeps the original fdt around and uses it as a starting point
for newly allocated expanded fdt. You don't know if the new fdt is big
enough until update_fdt() succeeds. But at that point, you already wrote
the efi-runtime-mmap property with the memory_map still having the
original cmdline and fdt in it.

I think you should be able to have an expand_fdt() function which bumps
the fdt size and uses the current fdt as the starting point instead of
the original fdt. That way you can free the original fdt on the first
iteration and free the original cmdline as soon as it is successfully
written. Then the last thing you do if get the memory_map and write it.

--Mark



        
     
