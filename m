From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 02 Jun 2014 14:51:14 +0200
Subject: [PATCH v2 1/7] arm: firmware: Check firmware is running or not
In-Reply-To: <1401712543-14281-2-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538C7342.4000700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> To support multi-platform, it needs to know it's running under secure
> OS or not.  Sometimes it needs to access physical address by SMC calls.
> 
> e.g.,
>         if (firmware_run()) {
>                 addr = physical address;
>         } else {
>                 addr = virtual address;
>         }
> 
>         call_firmware_ops(read_address, addr, &value);

Hmm, I don't understand the code above. It first asks whether the
firmware is available and then calls a firmware operation anyway
(assuming that firmware is available regardless of the check above)...

I don't like the idea of this function, because we have designed the
firmware API to not require this kind of checks. Instead, you just call
whatever firmware operation you need and if it returns -ENOSYS you need
to fallback to legacy (firmware-less) way of doing it.

Could you provide your use case for which this doesn't work?

Best regards,
Tomasz
