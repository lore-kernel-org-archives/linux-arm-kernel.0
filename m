From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 18 Oct 2017 11:04:28 +0800
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
In-Reply-To: <20171017164336.cedso3f35lpeam7f@pd.tnic>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
Message-ID: <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,Borislav

On 2017/10/18 0:43, Borislav Petkov wrote:
>> -}
>> -
> So GHES NMI notification method is x86-only AFAIK and HAVE_ACPI_APEI_NMI
> is selected only on x86. Why are you removing those guards? Does ARM
> have ACPI_HEST_NOTIFY_NMI notification type now too?

ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only used by x86.
In the code, I see those guards are never used. As you see, if the 'CONFIG_HAVE_ACPI_APEI_NMI'
does not defined in [1], it will print error info and goto [2], in the [2], it will return error,
then the probe for GHES NMI is failed. so those guards( ghes_nmi_add() and ghes_nmi_remove()) have no chance
to execute. so I redefine them to NULL for compiling[3].

    static int ghes_probe(struct platform_device *ghes_dev)
    {
      struct acpi_hest_generic *generic;
      struct ghes *ghes = NULL;

      int rc = -EINVAL;

       switch (generic->notify.type) {
	   ...................
       case ACPI_HEST_NOTIFY_NMI:                        [1]
          if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
              pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
                  generic->header.source_id);
              goto err;
          }
           ..............
	  }
	  switch (generic->notify.type) {
          ...............
          case ACPI_HEST_NOTIFY_NMI:
             ghes_nmi_add(ghes);
             break;
          }
          ..........
 err:                                                [2]
      if (ghes) {
          ghes_fini(ghes);
          kfree(ghes);
      }
      return rc;
    }

[3]:
-static inline void ghes_nmi_add(struct ghes *ghes)
-{
-       pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
-              ghes->generic->header.source_id);
-       BUG();
-}
-
-static inline void ghes_nmi_remove(struct ghes *ghes)
-{
-       pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
-              ghes->generic->header.source_id);
-       BUG();
-}
-
-static inline void ghes_nmi_init_cxt(void)
-{
-}
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+static inline void ghes_nmi_init_cxt(void) { }
