From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 9 Jan 2018 09:47:31 +0000
Subject: Hang loading omap_rng on MacchiatoBin with 4.15-rc7
In-Reply-To: <CAAqcGH=eG6PC2gmJ0MxOkLYProM3DqbE-cz=hSz1jEPGiBdTLg@mail.gmail.com>
References: <CAAqcGH=eG6PC2gmJ0MxOkLYProM3DqbE-cz=hSz1jEPGiBdTLg@mail.gmail.com>
Message-ID: <CAKv+Gu8ubQUFG0ggOjUUVCDC+VtBdSn6bjK=ujC6UKrAcDeUEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2018 at 08:31, Riku Voipio <riku.voipio@linaro.org> wrote:
> Hi,
>
> Loading omap_rng module on McBin causes hangup (in about 9/10 times).
> Looking at /proc/interrupts it seems the interrupt starts running like
> crazy, and after a while the whole system is unresponsive. This with
> Debian kernel (everything possible as modules) and EFI as bootloader.
> The EFI firmware appears[1] to use the rng unit to provide a seed for
> KASRL, I wonder if the driver needs to depend less on the state left
> by firmware, or the firmware needs to de-initialize the RNG before
> booting.
>
...
>  87:          0          0          0          0  ICU.f21e0000  95
> Level     f2760000.trng
>  88:    2532580          0          0          0  ICU.f41e0000  95
> Level     f4760000.trng
...

My original code had

gMarvellTokenSpaceGuid.PcdEip76TrngBaseAddress|0xF2760000

which means the interrupt storm is being caused by the /other/ RNG,
not the one UEFI uses.

Could you please check whether your UEFI source is still using the
same base address?
