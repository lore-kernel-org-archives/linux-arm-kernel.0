From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 19:48:13 +0000
Subject: [PATCH v2 11/12] ARM: wire up UEFI init and runtime support
In-Reply-To: <CAKv+Gu8w+2GA5tV4roYtEsza+mkCZKYX_=tT2t=+eh-ZO1Y2fA@mail.gmail.com>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-12-git-send-email-ard.biesheuvel@linaro.org>
 <20151116190156.GH8644@n2100.arm.linux.org.uk>
 <CAKv+Gu8w+2GA5tV4roYtEsza+mkCZKYX_=tT2t=+eh-ZO1Y2fA@mail.gmail.com>
Message-ID: <20151116194812.GJ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 08:04:00PM +0100, Ard Biesheuvel wrote:
> OK. So you mean set TTBR to the zero page, perform the TLB flush and
> only then switch to the new page tables?

Not quite.

If you have global mappings below TASK_SIZE, you would need this
sequence when switching either to or from the UEFI page tables:

- switch to another set of page tables which only map kernel space
  with nothing at all in userspace.
- flush the TLB.
- switch to your target page tables.

As I say in response to one of your other patches, it's probably
much easier to avoid any global mappings below TASK_SIZE.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
