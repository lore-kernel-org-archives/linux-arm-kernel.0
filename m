From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 23 Oct 2017 15:38:59 +0300
Subject: Kernel panic when using ccm(aes) with the Atmel AES HW accelerator
In-Reply-To: <CAGkQfmP6Kq4DEBbGU7AW71PjbUJ2acdJF5PVDm6VqZkUaaoEzA@mail.gmail.com>
References: <CAGkQfmP6Kq4DEBbGU7AW71PjbUJ2acdJF5PVDm6VqZkUaaoEzA@mail.gmail.com>
Message-ID: <39a43561-e0e6-a3b7-e2c0-bd7e6bf1be47@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Romain,

On 10/18/2017 04:32 PM, Romain Izard wrote:
> my fix also led to a
> systematic oops when running the ccm(aes) test case.

The NULL deference appears because of a memory corruption issue.

atmel-aes does not implement ccm(aes), so the algorithm will be in the
following form: ccm_base(atmel-ctr-aes,cbcmac(aes-generic)).

ccm auth uses the first byte of the IV as length and eventually will
memset memory to zero based on that length (see set_msg_len()). CTR
overwrites the iv with the last ciphertext block and the length will be
wrong.

I will propose a fix, but I'm taking my time to better understand why
CTR requires to overwrite the iv with the last ciphertext block.

Cheers,
ta
