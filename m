From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Apr 2017 15:30:55 -0700
Subject: [v2,1/2] ARM: module: split core and init PLT sections
In-Reply-To: <1487715177-30790-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1487715177-30790-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <4e82258a-92b5-6ff2-49ee-484cd772650a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2017 02:12 PM, Ard Biesheuvel wrote:
> Since commit 35fa91eed817 ("ARM: kernel: merge core and init PLTs"),
> the ARM module PLT code allocates all PLT entries in a single core
> section, since the overhead of having a separate init PLT section is
> not justified by the small number of PLT entries usually required for
> init code.
> 
> However, the core and init module regions are allocated independently,
> and there is a corner case where the core region may be allocated from
> the VMALLOC region if the dedicated module region is exhausted, but the
> init region, being much smaller, can still be allocated from the module
> region. This puts the PLT entries out of reach of the relocated branch
> instructions, defeating the whole purpose of PLTs.
> 
> So split the core and init PLT regions, and name the latter ".init.plt"
> so it gets allocated along with (and sufficiently close to) the .init
> sections that it serves. Also, given that init PLT entries may need to
> be emitted for branches that target the core module, modify the logic
> that disregards defined symbols to only disregard symbols that are
> defined in the same section.
> 
> Fixes: 35fa91eed817 ("ARM: kernel: merge core and init PLTs")
> Reported-by: Angus Clark <angus@angusclark.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Ard, has this been submitted to Russell's patch tracker? If not, can you
do it?

Thanks a bunch!
-- 
Florian
