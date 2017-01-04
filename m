From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 4 Jan 2017 13:24:51 +0000
Subject: arm64: virt_to_page() does not return right page for a kernel
 image address
In-Reply-To: <e83640e2-61ed-4c29-b047-23965e670c08@redhat.com>
References: <CAHB_GuqqXqVu4i4eCZ3V_d8JbdSO6rjWpA_B0NMJsNc_Zw0Niw@mail.gmail.com>
 <20170104111119.GD8329@leverpostej>
 <c23ad459-9dab-2085-2e0d-91ad4cedc987@redhat.com>
 <20170104120602.GG8329@leverpostej>
 <e83640e2-61ed-4c29-b047-23965e670c08@redhat.com>
Message-ID: <CAKv+Gu_CRKb2TCKf+cC_SYMOg8o=tcOj6oj2CpO2rUXciDMK1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2017 at 12:23, Pratyush Anand <panand@redhat.com> wrote:
>
>
> On Wednesday 04 January 2017 05:36 PM, Mark Rutland wrote:
>>
>> So it seems we need to fix the crypto test.
>>
>> Looking at crypto/testmgr.c, I can't spot the kmap_atomic() or the
>> page_address()/virt_to_page(). I guess that's hidden behind helpers,
>> which might also be used elsewhere?
>>
>> Could you elaborate on where exactly the problem is in the crypto test?
>
>
> We have in test_acomp() -> crypto_acomp_decompress() -> tfm->decompress() ->
> scomp_acomp_decompress() -> scomp_acomp_comp_decomp() ->
> scatterwalk_map_and_copy() -> scatterwalk_copychunks()
>
>  41                 if (out != 2) {
>  42                         vaddr = scatterwalk_map(walk);
>  43                         memcpy_dir(buf, vaddr, len_this_page, out);
>  44                         scatterwalk_unmap(vaddr);
>  45                 }
>
>
> scatterwalk_map() gets vaddr from kmap_atomic().
>
> test_acomp() initializes sg:
> sg_init_one(&src, ctemplate[i].input, ilen);
>

This is the bug right here, and it is fixed already upstream. The
crypto test vectors are part of the kernel image, and should not be
used in scatterlists.

> ctemplate is a kernel address (like lzo_comp_tv_template), which was
> assigned to walk->sg latter and passed to kmap_atomic().
>
>
> ~Pratyush
