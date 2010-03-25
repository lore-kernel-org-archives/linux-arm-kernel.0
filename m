From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 25 Mar 2010 08:58:25 -0400
Subject: PXA3xx internal SRAM
In-Reply-To: <63386a3d1003221409j63413b5o7a0515836eaa8b86@mail.gmail.com>
References: <20100321124739.GG30801@buzzloop.caiaq.de>
	<63386a3d1003221409j63413b5o7a0515836eaa8b86@mail.gmail.com>
Message-ID: <771cded01003250558y6bf9a8b6q7fc969d448faa1df@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 5:09 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/3/21 Daniel Mack <daniel@caiaq.de>:
>
>> I wonder what this could be used for. Is there any kind of cache that
>> would be worth putting there to speed up things for example?
>
> Some ARM systems have TCM (Tightly Coupled Memory) which are similar
> in character but actually a feature of the ARM platforms rather than a custom
> memory for a certain SoC.
>
> You can find some documentation on how this can be used in
> Documentation/arm/tcm.txt, as you can see we can compile code there
> and the memory left after that can be used as a generic memory pool
> for fast always-on memory.
>

Hi Linus,

I just have some questions on tcm to understand it.

1. TCM may be structured as a Harvard architecture with seprate ITCM
and DTCM. It may also be structured as a Von Neumann architecture with
a unified TCM. It's depend on the silicon implementation. It seems
that current implementation of tcm module is for seprated ITCM & DTCM.
But if it's a unified TCM, we can't copy data into TCM in
initialization since there's no DTCM.

2. All free memory of ITCM and DTCM are joined into tcm_pool. Does it
mean that the purpose of all free memory is storing data, not
instruction?

3. Allocating memory could be from either ITCM or DTCM. If a piece for
program is copied into allocated memory of DTCM, could instruction of
this program piece be fetched from DTCM?

4. Both ITCM and DTCM is configured as uncached. Is it necessary to
export API to configure to cached in order to performance?

5. ARM supports smart cache that switch the functionality between TCM
and cache. Is it necessary to be supported by TCM module?

6. In current TCM module, reading co-processor instruction is
contained. It means that it's closely bind to ARM TCM. In custom SoC,
internal SRAM is just similar TCM. It doesn't support these
co-processor instruction of acquiring region and size. What's your
suggestion on supporting this kind of SoC in TCM module?

Thanks
Haojian
